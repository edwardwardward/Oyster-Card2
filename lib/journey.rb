
# CREATE METHOD TO CALCULATE FARE

class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :start, :finish, :fare

  def initialize
    @start = nil
    @finish = nil
    @fare = MINIMUM_FARE
  end


  def add_start(station)
    self.start = station
  end

  def add_finish(station)
    self.finish = station
  end

  def in_journey?
    !!start
  end

  def end_journey
    reset_fare
    self.start = nil
    self.finish = nil
  end

  def store_history
    {start => finish}
  end

  def penalty_fare
     self.fare = PENALTY_FARE
  end

  def reset_fare
    self.fare = MINIMUM_FARE
  end

  private

  attr_writer :start, :finish, :fare
end
