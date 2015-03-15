class NaughtyParticipant
  class StupidError < StandardError; end
  include Bumbleworks::LocalParticipant

  class << self
    attr_accessor :naughty_is_ok
  end

  def on_workitem
    if self.class.naughty_is_ok
      reply
    else
      raise StupidError, 'Oh crumb.'
    end
  end
end