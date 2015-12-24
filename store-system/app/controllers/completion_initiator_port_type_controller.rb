class CompletionInitiatorPortTypeController < ApplicationController

    def self.commit_response(coordination_context)
        client = Savon::Client.new(wsdl: coordination_context.completion_service)
        result = client.call(:commit, message: {'coordination_context' => 
            {
                'id' => coordination_context.id,
                'coordination_type' => coordination_context.coordination_type,
            },
        })
        r = result.to_hash[:commit_response][:result]
        r
    end

    def self.abort_response(provider_id, bank_id, coordination_context)
        abort_coordinator(coordination_context)
        abort_provider(provider_id, coordination_context)
        abort_bank(bank_id, coordination_context)
    end

    private

    def self.abort_coordinator(coordination_context)
        begin
            client = Savon::Client.new(wsdl: coordination_context.completion_service)
            result = client.call(:abort, message: {'abort_coordination_context' => 
                {
                    'id' => coordination_context.id,
                    'coordination_type' => coordination_context.coordination_type,
                },
            })
        rescue
            logger.info "Coordinator is offline"
        end
    end

    def self.abort_provider(provider_id, coordination_context)
        p = Provider.find(provider_id)
        begin
            client = Savon::Client.new(wsdl: p.wsdl_location)
            result = client.call(:abort_transaction, message: {'abort_coordination_context' => 
                {
                    'id' => coordination_context.id,
                    'coordination_type' => coordination_context.coordination_type,
                },
            })
        rescue
            logger.info "Provider is offline"
        end
    end

    def self.abort_bank(bank_id, coordination_context)
        b = Bank.find(bank_id)
        begin
            client = Savon::Client.new(wsdl: b.wsdl_location)
            result = client.call(:abort_transaction, message: {'abort_coordination_context' => 
                {
                    'id' => coordination_context.id,
                    'coordination_type' => coordination_context.coordination_type,
                },
            })
        rescue
            logger.info "Bank is offline"
        end
    end

end
