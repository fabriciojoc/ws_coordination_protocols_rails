class ActivationRequestorPortTypeController < ApplicationController

    COORDINATOR_ACTIVATION_WSDL = "http://localhost:3003/activation_coordinator_port_type/wsdl"

    def self.create_coordination_context_response
        client = Savon::Client.new(wsdl: COORDINATOR_ACTIVATION_WSDL)
        result = client.call(:create_coordination_context)
        r = result.to_hash[:create_coordination_context_response][:coordination_context]
        c = CoordinationContext.new(r[:coordination_type],r[:id], r[:registration_service])
        c
    end
end
