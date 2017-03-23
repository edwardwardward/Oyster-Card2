require_relative 'journey'
require_relative 'journeylog'
require_relative 'station'

class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :journeylog

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def touch_in(station)
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    penalty if journeylog.incomplete_journey?
    journeylog.start_journey(station)
  end

  def touch_out(station)
    if !journeylog.incomplete_journey?
      penalty
    else
      deduct
      journeylog.end_journey(station)
      journeylog.add_completed_journey
    end
  end

  private

  attr_writer :balance, :entry_station, :journeylog

  def penalty
    journeylog.journey_instance.penalty_fare
    deduct
    journeylog.journey_instance.reset_fare
  end

  def deduct
    self.balance -= journeylog.journey_instance.fare
  end

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAXIMUM_BALANCE
  end

  def balance_insufficient?
    balance < MINIMUM_BALANCE
  end

end
