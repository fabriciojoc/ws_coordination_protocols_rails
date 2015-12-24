class RegistrationRequestorPortTypeController < ApplicationController

  def self.register_response(coordination_context)
      client = Savon::Client.new(wsdl: coordination_context.registration_service)
      # regiter store to completion protocol
      result = client.call(:register, message: {'coordination_context' => 
        {
          'id' => coordination_context.id,
          'coordination_type' => coordination_context.coordination_type,
          'registration_service' => coordination_context.registration_service
        },
        'coordination_protocol' => '2pc',
        'client_service' => "http://localhost:3002/participant_port_type/wsdl"
      })
      r = result.to_hash
      coordinator_service = r[:register_response][:coordination_context_response][:coordinator_service]
      coordination_context.set_tpc_service(coordinator_service)
      $contexts[coordination_context.id] = coordination_context
      coordination_context
  end
end
