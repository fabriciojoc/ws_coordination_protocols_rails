class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_categories_and_providers

  def check_user_login
    if !current_user
      redirect_to new_user_session_path, alert: "Faça login para continuar."
    end
  end

  def check_user_permission
    if current_user.role != "admin"
      redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
    end
  end

  private

  def load_categories_and_providers
    @categories = []
    @providers = []
    Provider.all.each do |p|
      begin
          client = Savon.client(:wsdl => p.wsdl_location)
          response = client.call(:get_categories)
          categories = response.to_array(:get_categories_response, :categories)
          categories.each do |c|
            category = c.to_hash
            @categories << {:id => category[:id], :name => category[:name], :provider_id => p.id, :size => category[:size]}
          end
          response = client.call(:get_products_number)
          number = response.to_array(:get_products_number_response, :products_number).first
          @providers << {:id => p.id, :name => p.name, :number => number}
      rescue
          @error = true
      end
    end
  end
end
