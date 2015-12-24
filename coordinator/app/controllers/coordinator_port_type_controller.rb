class CoordinatorPortTypeController < ApplicationController

    def self.two_phase_commit(c)
        # voting phase
        results = []
        c.tpc_participants.each do |wsdl|
            # send prepare for each 2pc participant
            r = CoordinatorPortTypeController::prepare_response(wsdl,c)
            write_log(c,wsdl + " vote: " + r)
            results.push(r)
        end
        # commit phase
        # check voting results
        if results.include? "abort"
            # rollback
            write_log(c, "rollback")
            for i in 0..c.tpc_participants.size-1 do
                # send rollback for each 2pc participant that votted 'prepared'
                if results[i] == 'prepared'
                    r = CoordinatorPortTypeController::rollback_response(c.tpc_participants[i],c)
                end
            end
            "aborted"
        else
            # commit
            write_log(c, "commit")
            c.tpc_participants.each do |wsdl|
                # send commit for each 2pc participant
                r = CoordinatorPortTypeController::commit_response(wsdl,c)
            end
            "committed"
        end
    end


    def self.prepare_response(participant_wsdl,coordination_context)
        logger.info participant_wsdl
        client = Savon::Client.new(wsdl: participant_wsdl)
        result = client.call(:prepare, message: {'coordination_context' => 
            {
                'id' => coordination_context.id,
                'coordination_type' => coordination_context.coordination_type,
            },
        })
        r = result.to_hash[:prepare_response][:result]
        r
    end


    def self.commit_response(participant_wsdl,coordination_context)
        logger.info participant_wsdl
        client = Savon::Client.new(wsdl: participant_wsdl)
        result = client.call(:commit, message: {'commit_coordination_context' => 
            {
                'id' => coordination_context.id,
                'coordination_type' => coordination_context.coordination_type,
            },
        })
        r = result.to_hash[:commit_response][:result]
        r
    end

    def self.rollback_response(participant_wsdl,coordination_context)
        logger.info participant_wsdl
        client = Savon::Client.new(wsdl: participant_wsdl)
        result = client.call(:rollback, message: {'rollback_coordination_context' => 
            {
                'id' => coordination_context.id,
                'coordination_type' => coordination_context.coordination_type,
            },
        })
        r = result.to_hash[:rollback_response][:result]
        r
    end

    def self.write_log(c, text)
        logger = Logger.new("#{Rails.root}/log/"+c.id.to_s+'.log')
        logger.formatter = proc do |severity, datetime, progname, msg|
            "#{msg}\n"
        end
        logger.info(text)
    end
end
