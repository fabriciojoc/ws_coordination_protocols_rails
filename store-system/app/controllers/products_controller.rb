class ProductsController < ApplicationController
  before_filter :load_all_products, only: [:index]
  before_filter :load_product, only: [:show_product, :buy_product, :new_product_purchase]
  before_filter :check_user_login, only: [:buy_product, :new_product_purchase] 
  before_filter :validate_buy_product_form, only: [:new_product_purchase]

  $mutexes = Hash.new

  def index
  end

  def show_product
  end

  def buy_product
    if @product[:amount].to_i <= 0
      redirect_to show_product_path(provider_id: params[:provider_id], product_id: params[:product_id]), alert: "Produto indisponível."
    end
    @form_errors = []
    @purchase = Purchase.new
  end

  def new_product_purchase
    @purchase = Purchase.new(purchase_params)
    @purchase.provider_id = params[:provider_id]
    @purchase.product_name = @product[:name]
    @purchase.price = Provider.find(params[:provider_id]).percentage.to_f * @product[:price].to_f
    @purchase.user = current_user if current_user
    @purchase.status = "Comprado"
    respond_to do |format|
      if @purchase.valid? && @form_errors.size <= 0
        # create new coordination context
        begin
          c = ActivationRequestorPortTypeController::create_coordination_context_response
          # register in completion protocol
          c = RegistrationRequestorPortTypeController::register_response(c)
          # send coordination context to provider: it will register in 2pc protocol
          result_provider = MessagePortTypeController::send_product_response(params[:provider_id], params[:product_id], c)
          # send coordination context to bank: it will register in 2pc protocol
          result_bank = MessagePortTypeController::send_card_response(params[:purchase][:bank_id], params[:purchase][:card_number], params[:card_password], params[:card_code], @purchase.price.to_s, c)
          # check results
          if result_provider && result_bank
            # start 2pc
            r = CompletionInitiatorPortTypeController::commit_response(c)

            if r == 'committed'
              # 2pc committed
              @purchase.save
              format.html { redirect_to my_purchases_path, notice: 'Compra efetuada com sucesso!' }
            else
              # 2pc aborted
              @form_errors.push("Produto indisponível e/ou cartão inválido.")
              format.html { render :buy_product }
              format.json { render json: @purchase.errors, status: :unprocessable_entity }
            end
          else 
            # abort 2pc
            CompletionInitiatorPortTypeController::abort_response(params[:provider_id],params[:purchase][:bank_id],c)
            @form_errors.push("Problema de conexão com os servidores.")
            format.html { render :buy_product }
            format.json { render json: @purchase.errors, status: :unprocessable_entity }
          end
        rescue
          @form_errors.push("Problema de conexão com os servidores")
          CompletionInitiatorPortTypeController::abort_response(params[:provider_id],params[:purchase][:bank_id],c)
          format.html { render :buy_product }
          format.json { render json: @purchase.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :buy_product }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def load_product
    # search provider
    begin
      @provider = Provider.find(params[:provider_id])
    rescue
      logger.info 'invalid provider'
      return redirect_to root_path, alert: "Fornecedor inválido."
    end
    # get product_info
    begin
      client = Savon.client(:wsdl => @provider.wsdl_location)
      response = client.call(:get_product_info, message: { "product_id" => params[:product_id] })
      product = response.to_array(:get_product_info_response, :product_info).first.to_hash
      @product = { :id => product[:id], :name => product[:name], :description => product[:description], :price => product[:price].to_f, :category => product[:category], :category_id => product[:category_id], :photo => product[:photo], :video => product[:video], :amount => product[:amount] }
    rescue
      logger.info 'invalid product'
      return redirect_to root_path, alert: "Produto inválido."
    end
  end

  def load_all_products
    @products = []
    Provider.all.each do |p|
      begin
          client = Savon.client(:wsdl => p.wsdl_location)
          response = client.call(:get_all_products)
          products = response.to_array(:get_all_products_response, :products)
          products.each do |c|
            product = c.to_hash
            @products << {:id => product[:id], :name => product[:name], :price => product[:price], :provider_id => p.id, :photo => product[:photo]}
          end
      rescue
          logger.info 'error'
          @error = true
      end
    end
  end

  def validate_buy_product_form
    @form_errors = []
    if params[:card_password].empty?
      @form_errors.push "Senha não pode ficar em branco."
    end
    if params[:card_password].size < 6 || params[:card_password].size > 128
      @form_errors.push "Senha deve ter ao menos 6 caracteres."
    end
    if params[:card_code].size < 3
      @form_errors.push "Código de segurança deve ter 3 caracteres."
    end
    if params[:card_code].empty?
      @form_errors.push "Código de segurança não pode ficar em branco."
    end
  end

  def purchase_params
    params.require(:purchase).permit(:product_id, :price, :card_number, :provider_id, :bank_id)
  end
end
