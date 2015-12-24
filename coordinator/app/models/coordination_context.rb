class CoordinationContext
  def initialize(coordination_type)
    @id = self.object_id
    @coordination_type = coordination_type
    @completion_participants = []
    @tpc_participants = []
  end

  def id
    @id
  end

  def coordination_type
    @coordination_type
  end

  def completion_participants
    @completion_participants
  end

  def tpc_participants
    @tpc_participants
  end
end