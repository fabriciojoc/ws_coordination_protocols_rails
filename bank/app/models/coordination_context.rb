class CoordinationContext
  def initialize(coordination_type, id, registration_service, card_number, card_password, card_security_code, value)
    @id = id
    @coordination_type = coordination_type
    @registration_service = registration_service
    @card_number = card_number
    @card_password = card_password
    @card_security_code = card_security_code
    @value = value
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

  def card_number
    @card_number
  end

  def card_password
    @card_password
  end

  def card_security_code
    @card_security_code
  end

  def value
    @value
  end

  def tpc_service
    @tpc_service
  end

  def set_tpc_service(service)
    @tpc_service = service
  end

  def account
    @account
  end

  def set_account(account)
    @account = account
  end

end