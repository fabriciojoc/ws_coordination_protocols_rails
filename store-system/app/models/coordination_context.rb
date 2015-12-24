class CoordinationContext
  def initialize(coordination_type, id, registration_service)
    @id = id
    @coordination_type = coordination_type
    @registration_service = registration_service
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

  def completion_service
    @completion_service
  end

  def set_completion_service(service)
    @completion_service = service
  end

end