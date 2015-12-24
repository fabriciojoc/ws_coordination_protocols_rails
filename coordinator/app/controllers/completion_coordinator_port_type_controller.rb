class CompletionCoordinatorPortTypeController < ApplicationController
    soap_service namespace: 'coordinator:CompletionCoordinatorPortType'

    soap_action 'commit',
                :args => {
                    :coordination_context => {
                        :id => :integer,
                        :coordination_type => :string,
                    },
                },
                :return => {
                    :result => :string
                }

    def commit
        c = $contexts[params[:coordination_context][:id]]
        result = two_phase_commit_response(c)
        # destroy coordination context
        c = nil
        $contexts.delete(params[:coordination_context][:id])
        render :soap => { :result => result }
    end

    soap_action 'abort',
        :args => {
            :abort_coordination_context => {
                :id => :integer,
                :coordination_type => :string,
            },
        },
        :return => {
            :result => :boolean
        }

    def abort
        logger.info $contexts
        c = $contexts[params[:abort_coordination_context][:id]]
        c = nil
        $contexts.delete(params[:abort_coordination_context][:id])
        render :soap => { :result => true }
    end


    private

    def two_phase_commit_response(c)
        CoordinatorPortTypeController::two_phase_commit(c)
    end
end
