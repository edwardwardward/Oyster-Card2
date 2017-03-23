class JourneyLog

  attr_reader :journey_history
  
  def initialize
    @journey_history = []
  end

  def store_history(current_journey)
    journey_history << current_journey
  end

  private
  attr_writer :journey_history

end
