class ProviderController < ApplicationController
  soap_service namespace: 'urn:WSProvider'

  soap_action "get_all_products",
              :args => {},
              :return => { :products => [
                                          :id => :integer,
                                          :name => :string, 
                                          :description => :string, 
                                          :price => :string, 
                                          :amount => :string, 
                                          :category => :string,
                                          :photo => :string
                                        ] 
                         }

  def get_all_products
    products = []
    Product.all.each do |p|
      if !p.description.empty?
        description = p.description
      else
        description = "Nenhuma descrição."
      end

      if p.photo_file_name 
        photo = root_url + p.photo.url(:medium)
      else
        photo = root_url + ActionController::Base.helpers.asset_path('product.jpg')
      end

      products << { :id => p.id, :name => p.name, :description => description, :price => p.price.to_f, :amount => p.amount, :category => p.category.name, :photo => photo}
    end
    render :soap => { :products => products }
  end

  soap_action "get_categories",
              :args => {},
              :return => { :categories => [
                                           :id => :integer,
                                           :name => :string, 
                                           :size => :integer
                                          ] 
                         }

  def get_categories
    categories = []
    Category.all.each do |c|
      categories << {:id => c.id, :name => c.name, :size => c.products.size}
    end
    render :soap => { :categories => categories }
  end

  soap_action "get_products_by_category",
              :args => { :category_id => :integer },
              :return => { :category_products => [
                                          :id => :integer,
                                          :name => :string, 
                                          :description => :string, 
                                          :price => :string, 
                                          :amount => :string, 
                                          :category => :string
                                        ] 
                         }

  def get_products_by_category
    category_products = []
    search = Product.where(:category_id => params[:category_id])
    search.each do |p|
      if !p.description.empty?
        description = p.description
      else
        description = "Nenhuma descrição."
      end
      category_products << { :id => p.id, :name => p.name, :description => description, :price => p.price.to_f, :amount => p.amount, :category => p.category.name}
    end
    render :soap => { :category_products => category_products }
  end

  soap_action "get_product_info",
              :args => { :product_id => :integer },
              :return => { :product_info => {
                                              :id => :integer,
                                              :name => :string, 
                                              :description => :string, 
                                              :price => :string, 
                                              :amount => :string, 
                                              :category => :string,
                                              :category_id => :integer,
                                              :photo => :string,
                                              :video => :string,
                                              :amount => :integer
                                            }
                         }

  def get_product_info
    begin
      product = Product.find(params[:product_id])
      if !product.description.empty?
        description = product.description
      else
        description = "Nenhuma descrição."
      end
      if !product.video
        video = "no-video"
      else
        video = product.video
      end
      render :soap => { :product_info => { 
                                            :id => product.id, 
                                            :name => product.name, 
                                            :description => description, 
                                            :price => product.price.to_f, 
                                            :amount => product.amount, 
                                            :category => product.category.name,
                                            :category_id => product.category_id,
                                            :photo => root_url + product.photo.url(:medium),
                                            :video => video,
                                            :amount => product.amount
                                          } 
                      }
    rescue
      raise SOAPError, "Produto não encontrado."
    end
  end

  soap_action "get_products_number",
              :args => {},
              :return => { :products_number => :integer }

  def get_products_number
    begin
      render :soap => { :products_number => Product.all.count }
    rescue
      raise SOAPError, "Erro."
    end
  end

  soap_action "update_product_amount",
              :args => { :product_id => :integer },
              :return => { }

  def update_product_amount
    begin
      product = Product.find(params[:product_id])
      product.amount -= 1
      product.save!
      render :soap => { }
    rescue
      raise SOAPError, "Erro."
    end
  end

    soap_action 'send_product',
                :args => {
                    :coordination_context => {
                        :id => :integer,
                        :coordination_type => :string,
                        :coordinator_registration_service => :string,
                        :product_id => :integer
                    },
                },
                :return => { 
                    :result => :boolean
                }

    def send_product
      id = params[:coordination_context][:id]
      coordination_type = params[:coordination_context][:coordination_type]
      registration_service = params[:coordination_context][:coordinator_registration_service]
      product_id = params[:coordination_context][:product_id]
      c = CoordinationContext.new(coordination_type, id, registration_service, product_id)
      write_log(c,'Coordination context: ' + params.to_s)
      c = register(c)
      if c
        render :soap => { :result => true}
      else
        render :soap => { :result => false}
      end
    end

    soap_action 'abort_transaction',
        :args => {
            :abort_coordination_context => {
                :id => :integer,
                :coordination_type => :string,
            },
        },
        :return => {
            :result => :boolean
        }

    def abort_transaction
        c = $contexts[params[:abort_coordination_context][:id]]
        c = nil
        $contexts.delete(params[:abort_coordination_context][:id])
        render :soap => { :result => true }
    end

    private

    def register(c)
      RegistrationRequestorPortTypeController::register_response(c)
    end

end
