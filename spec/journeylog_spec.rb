require 'journeylog'

describe JourneyLog do
  let(:journey) { double :journey }
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  subject(:journeylog) {described_class.new(journey_class: journey_class)}

  describe '#start_journey' do
    it 'takes 1 argument' do
      expect(journeylog).to respond_to(:start_journey).with(1).argument
    end
  end

  describe '#ends_journey' do
    it 'takes 1 argument' do
      expect(journeylog).to respond_to(:end_journey).with(1).argument
    end
  end

  describe '#add_completed_journey' do
    it 'array contains previous journey' do
      journeylog.add_completed_journey
      allow(journey_class).to recieve(:store_history) {:station}
      expect(journeylog.journey_history).to include journey_class
    end
  end

end
