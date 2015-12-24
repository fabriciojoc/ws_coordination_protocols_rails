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
      if c
        p = Product.find(c.product_id)
        if p
            p.transaction do
                if p.transaction_amount > 0
                    p.transaction_amount -= 1
                    p.save!
                    write_log(c, "2PC Vote: prepared")
                    render :soap => { :result => 'prepared'}
                else
                    write_log(c, "2PC Vote: abort")
                    c = nil
                    $contexts.delete(id)
                    render :soap => { :result => 'abort'}
                end
            end
        else
            write_log(c, "2PC Vote: abort")
            c = nil
            $contexts.delete(id)
            render :soap => { :result => 'abort'}
        end
      else
        write_log(c, "2PC Vote: abort")
        c = nil
        $contexts.delete(id)
        render :soap => { :result => 'abort'}
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
      p = Product.find(c.product_id)
      p.transaction do
          p.amount -= 1
          p.save!
          write_log(c, "2PC Result: committed")
      end
      # destroy coordination context
      c = nil
      $contexts.delete(id)
      render :soap => { :result => 'committed'}
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
      p = Product.find(c.product_id)
      p.transaction do
          p.transaction_amount += 1
          p.save!
          write_log(c, "2PC Result: aborted")
      end
      # destroy coordination context
      c = nil
      $contexts.delete(id)
      render :soap => { :result => 'aborted'}
    end

end
