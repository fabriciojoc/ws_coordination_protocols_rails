class ActivationCoordinatorPortTypeController < ApplicationController
    soap_service namespace: 'coordinator:ActivationCoordinatorPortType'

    soap_action 'create_coordination_context',
                :args => {},
                :return => { 
                    :coordination_context => {
                        :id => :integer,
                        :coordination_type => :string,
                        :registration_service => :string
                    } 
                    
                }
    def create_coordination_context
        c = CoordinationContext.new("ws-t")
        write_log(c, 'Coordination context: ' + c.inspect)
        $contexts[c.id] = c
        render :soap => { :coordination_context => {:id => c.id, :coordination_type => c.coordination_type, :registration_service => "http://localhost:3003/registration_coordinator_port_type/wsdl" } }
    end
end
