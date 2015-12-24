class CoordinationContext
  def initialize(coordination_type, id, registration_service, product_id)
    @id = id
    @coordination_type = coordination_type
    @registration_service = registration_service
    @product_id = product_id
  end

  def id
    @id
  end

  def coordination_type
    @coordination_type
  end

  def registration_service
    @registration_service
  end

  def product_id
    @product_id
  end

  def tpc_service
    @tpc_service
  end

  def set_tpc_service(service)
    @tpc_service = service
  end

  def product
    @product
  end

  def set_product(product)
    @product = product
  end

end