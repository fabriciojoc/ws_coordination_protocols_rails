class ParticipantPortTypeController < ApplicationController
    soap_service namespace: 'participant:ParticipantPortType'

    soap_action 'prepare',
                :args => {
                    :coordination_context => {
                        :id => :integer,
                        :coordination_type => :string,
                    },
                },
                :return => { 
                    :result => :string,
                }

    def prepare
      id = params[:coordination_context][:id]
      c = $contexts[id]
      card = Card.where(:number => c.card_number)
      if card.size > 0
        card = card.first
        if card.password == c.card_password
          if card.security_code == c.card_security_code
            card.account.transaction do
              if card.account.transaction_balance >= c.value.to_f
                card.account.transaction_balance -= c.value.to_f
                card.account.save!
                write_log(c,'2PC Vote: prepared')
                render :soap => { :result => 'prepared' }
              else
                write_log(c,'2PC Vote: abort')
                c = nil
                $contexts.delete(id)
                render :soap => { :result => 'abort' }
              end
            end
          else
            write_log(c,'2PC Vote: abort')
            c = nil
            $contexts.delete(id)
            render :soap => { :result => 'abort' }
          end
        else
          write_log(c,'2PC Vote: abort')
          c = nil
          $contexts.delete(id)
          render :soap => { :result => 'abort' }
        end
      else
        write_log(c,'2PC Vote: abort')
        c = nil
        $contexts.delete(id)
        render :soap => { :result => 'abort' }
      end
    end

    soap_action 'commit',
                :args => {
                    :commit_coordination_context => {
                        :id => :integer,
                        :coordination_type => :string,
                    },
                },
                :return => { 
                    :result => :string,
                }

    def commit
      id = params[:commit_coordination_context][:id]
      c = $contexts[id]
      card = Card.where(:number => c.card_number).first
      card.account.transaction do
        card.account.balance -= c.value.to_f
        card.account.save!
        write_log(c,'2PC Result: committed')
      end
      # destroy coordination context
      c = nil
      $contexts.delete(id)
      render :soap => { :result => 'committed' }
    end

    soap_action 'rollback',
                :args => {
                    :rollback_coordination_context => {
                        :id => :integer,
                        :coordination_type => :string,
                    },
                },
                :return => { 
                    :result => :string,
                }

    def rollback
      id = params[:rollback_coordination_context][:id]
      c = $contexts[id]
      card = Card.where(:number => c.card_number).first
      card.account.transaction do
        card.account.transaction_balance += c.value.to_f
        card.account.save!
        write_log(c,'2PC Result: aborted')
      end
      # destroy coordination context
      c = nil
      $contexts.delete(id)
      render :soap => { :result => 'aborted' }
    end

end
