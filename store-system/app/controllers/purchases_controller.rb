class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :check_user_login
  before_action :check_user_permission, except: [:my_purchases, :show]
  before_action :my_purchases_only, only: [:show]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
  end

  # GET /my_purchases
  # GET /my_purchases.json
  def my_purchases
    if current_user
      @purchases = Purchase.where(:user_id => current_user.id)
    else 
      redirect_to root_path, alert: "Você não está logado!"
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  # def new
  #   @purchase = Purchase.new
  # end

  # GET /purchases/1/edit
  # def edit
  # end

  # POST /purchases
  # POST /purchases.json
  # def create
  #   @purchase = Purchase.new(purchase_params)

  #   respond_to do |format|
  #     if @purchase.save
  #       format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
  #       format.json { render :show, status: :created, location: @purchase }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @purchase.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  # def update
  #   respond_to do |format|
  #     if @purchase.update(purchase_params)
  #       format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @purchase }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @purchase.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:product_id, :price, :card_number, :provider_id, :bank_id)
    end

    def my_purchases_only
      if current_user.role != "admin"
        if @purchase.user_id != current_user.id
          redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
        end
      end
    end
end
