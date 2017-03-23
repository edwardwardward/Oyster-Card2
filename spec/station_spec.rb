require 'station'

describe Station do

subject(:station) {described_class.new(:london_bridge,:one)}

  describe '#initialize' do
    it 'a station name' do
      expect(station.name).to eq :london_bridge
    end
    it 'a zone' do
      expect(station.zone).to eq :one
    end
  end
end
