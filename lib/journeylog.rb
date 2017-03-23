class JourneyLog

  attr_reader :journey_history, :journey_instance

  def initialize(journey_instance = Journey.new)
    @journey_instance = journey_instance
    @journey_history = []
  end

  def start_journey(entry_station)
    journey_instance.add_start(entry_station)
  end

  def end_journey(exit_station)
    journey_instance.add_finish(exit_station)
  end

  def add_completed_journey
    journey_history << journey_instance.store_history
  end

  def incomplete_journey?
    journey_instance.in_journey?
  end

  private

  attr_writer :journey_history
end
