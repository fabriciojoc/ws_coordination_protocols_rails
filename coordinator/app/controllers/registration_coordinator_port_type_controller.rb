class RegistrationCoordinatorPortTypeController < ApplicationController
    soap_service namespace: 'coordinator:RegistrationCoordinatorPortType'

    soap_action 'register',
                :args => {
                    :coordination_context => {
                        :id => :integer,
                        :coordination_type => :string,
                        :registration_service => :string
                    },
                    :coordination_protocol => :string,
                    :client_service => :string
                },
                :return => { 
                    :coordination_context_response => {
                        :id => :integer,
                        :coordination_type => :string,
                        :coordinator_service => :string
                    } 
                    
                }

    def register
      begin
        c = $contexts[params[:coordination_context][:id]]
      rescue
        render :soap => nil
      end

      if params[:coordination_protocol] == 'completion'
        c.completion_participants.push params[:client_service]
        write_log(c, 'Completion participant: ' + params[:client_service])
        render :soap => { :coordination_context_response => {:id => c.id, :coordination_type => c.coordination_type, :coordinator_service => "http://localhost:3003/completion_coordinator_port_type/wsdl" } }
      elsif params[:coordination_protocol] == '2pc'
        c.tpc_participants.push params[:client_service]
        write_log(c, '2PC participant: ' + params[:client_service])
        render :soap => { :coordination_context_response => {:id => c.id, :coordination_type => c.coordination_type, :coordinator_service => "http://localhost:3003/coordinator_port_type/wsdl" } }
      else
        render :soap => nil
      end
    end
end
