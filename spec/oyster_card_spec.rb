require 'oyster_card'

describe OysterCard do

  subject(:oyster_card) {described_class.new}
  let(:london_bridge) {double:station}
  let(:bermondsey) {double:station}

  describe '#balance' do
    it 'responds to balance enquiry' do
      expect(oyster_card).to respond_to(:balance)
    end

    it "defaults to 0 balance" do
      expect(oyster_card.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'receive top_up value and update balance' do
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq(20)
    end

    it 'maximum balance raises error' do
      expect {oyster_card.top_up(95)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAXIMUM_BALANCE}) exceeded")
    end
  end

  describe "#touch_in" do
    it "penalty charge when trying to touch_in twice" do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect { oyster_card.touch_in(london_bridge) }.to change{oyster_card.balance}.by -Journey::PENALTY_FARE
    end

    it "minimum funds needed to travel" do
      expect{oyster_card.touch_in(london_bridge)}.to raise_error 'Cannot touch in: insufficient funds. Please top up'
    end

    it 'records start station' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect(oyster_card.journeylog.start).to eq london_bridge
    end
  end

  describe "#touch_out" do
    it 'not in journey' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_out(bermondsey)
      expect(oyster_card.journeylog).not_to be_in_journey
    end

    it "penalty fare if no touch in" do
      expect { oyster_card.touch_out(bermondsey) }.to change{oyster_card.balance}.by -Journey::PENALTY_FARE
    end

    it 'deduct minimum fare from balance' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect {oyster_card.touch_out(bermondsey)}.to change{oyster_card.balance}.by -OysterCard::MINIMUM_BALANCE
    end

    it 'resets journey' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect {oyster_card.touch_out(bermondsey)}.to change{oyster_card.journeylog.start}.to nil
    end
  end

  describe "#journey_history" do
    it 'complete journey stored in journey_history' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_out(bermondsey)
      expect(oyster_card.journey_history).to include ({london_bridge => bermondsey})
    end
  end
end
