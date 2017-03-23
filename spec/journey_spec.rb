require 'journey'

describe Journey do
  let(:london_bridge) {double:station}
  let(:bermondsey) {double:station}
  subject(:journey) {described_class.new}

  describe '#add_start' do
    it 'adds a station' do
      journey.add_start(london_bridge)
      expect(journey.start).to eq london_bridge
    end
  end

  describe '#add_finish' do
    it 'adds a station' do
      journey.add_finish(london_bridge)
      expect(journey.finish).to eq london_bridge
      end
    end

  describe "#in_journey?" do
    it 'returns false if journey has not started' do
      expect(journey).not_to be_in_journey
    end
  end

  describe "#penalty_fare" do
    it 'checks penalty fare can be set' do
      journey.penalty_fare
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end
