class BankController < ApplicationController
  soap_service namespace: 'urn:WSBank'

  soap_action "credit_card_draw",
              :args => { :card_number => :string,
                         :card_password => :string,
                         :card_security_code => :string,
                         :value => :string },
              :return => { :sucess => :boolean,
                           :message => :string }

  def credit_card_draw
    card = Card.where(:number => params[:card_number])
    if card.size > 0
      card = card.first
      if card.password == params[:card_password]
        if card.security_code == params[:card_security_code]
          if card.account.balance >= params[:value].to_f
            card.account.balance -= params[:value].to_f
            card.account.save!
            render :soap => { :sucess => true, :message => "Transação efetuada com sucesso." }
          else
            render :soap => { :sucess => false, :message => "Saldo insuficiente." }
          end
        else
          render :soap => { :sucess => false, :message => "Código de segurança inválida." }
        end
      else
        render :soap => { :sucess => false, :message => "Senha inválida." }
      end
    else
      render :soap => { :sucess => false, :message => "Cartão inválido." }
    end
  end

  soap_action 'send_card',
              :args => {
                  :coordination_context => {
                      :id => :integer,
                      :coordination_type => :string,
                      :coordinator_registration_service => :string,
                      :card_number => :string,
                      :card_password => :string,
                      :card_security_code => :string,
                      :value => :string
                  },
              },
              :return => { 
                  :result => :boolean
              }

  def send_card
    id = params[:coordination_context][:id]
    coordination_type = params[:coordination_context][:coordination_type]
    registration_service = params[:coordination_context][:coordinator_registration_service]
    card_number = params[:coordination_context][:card_number]
    card_password = params[:coordination_context][:card_password]
    card_security_code = params[:coordination_context][:card_security_code]
    value = params[:coordination_context][:value]
    c = CoordinationContext.new(coordination_type, id, registration_service, card_number, card_password, card_security_code, value)
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
