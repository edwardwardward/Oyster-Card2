require_relative 'journey'
require_relative 'journeylog'
require_relative 'station'

class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :journey_history, :trip

  def initialize
    @balance = 0
    @journey_history = []
    @trip = Journey.new
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def touch_in(station)
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    penalty if trip.in_journey?
    trip.add_start(station)
  end

  def touch_out(station)
    if !trip.in_journey?
      penalty
    else
      deduct
      trip.add_finish(station)
      journey_history << trip.store_history
      trip.end_journey
    end
  end

  private

  attr_writer :balance, :entry_station, :trip

  def penalty
    trip.penalty_fare
    deduct
    trip.reset_fare
  end

  def deduct
    self.balance -= trip.fare
  end

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAXIMUM_BALANCE
  end

  def balance_insufficient?
    balance < MINIMUM_BALANCE
  end

end
