class MessagePortTypeController < ApplicationController
    def self.send_product_response(provider_id, product_id, coordination_context)
        p = Provider.find(provider_id)
        client = Savon::Client.new(wsdl: p.wsdl_location)
        # send product_id and coordination_context to provider
        begin 
            result = client.call(:send_product, message: {'coordination_context' => 
                {
                    'id' => coordination_context.id,
                    'coordination_type' => coordination_context.coordination_type,
                    'coordinator_registration_service' => coordination_context.registration_service,
                    'product_id' => product_id
                },
            })
        rescue
            logger.info "Provider is offline"
        end
        if result
            r = result.to_hash
            result = r[:send_product_response][:result]
        else
            result = false
        end
        result
    end

    def self.send_card_response(bank_id, card_number, card_password, card_security_code, value, coordination_context)
        b = Bank.find(bank_id)
        client = Savon::Client.new(wsdl: b.wsdl_location)
        # send card_number and coordination_context to provider
        begin
            result = client.call(:send_card, message: {'coordination_context' => 
                {
                    'id' => coordination_context.id,
                    'coordination_type' => coordination_context.coordination_type,
                    'coordinator_registration_service' => coordination_context.registration_service,
                    'card_number' => card_number,
                    'card_password' => card_password,
                    'card_security_code' => card_security_code,
                    'value' => value
                },
            })
        rescue
            logger.info "Bank is ofline"
        end
        if result
            r = result.to_hash
            result = r[:send_card_response][:result]
        else
            result = false
        end
        result
    end
end
