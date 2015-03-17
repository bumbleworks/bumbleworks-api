describe TimeSupport do
  describe '.seconds_to_units' do
    it 'returns hash of subdivided units for given seconds' do
      described_class.seconds_to_units(33924.5).should eq({
        :hours => 9,
        :minutes => 25,
        :seconds => 24
      })
    end

    it 'includes zero units if requested' do
      described_class.seconds_to_units(33924.5, include_zeros: true).should eq({
        :days => 0,
        :hours => 9,
        :minutes => 25,
        :seconds => 24
      })
    end

    it 'does not round seconds if switched off' do
      described_class.seconds_to_units(33924.5, round_seconds: false).should eq({
        :hours => 9,
        :minutes => 25,
        :seconds => 24.5
      })
    end
  end

  describe '.seconds_to_units_in_words' do
    it 'wordifies response from seconds_to_units' do
      allow(described_class).to receive(:seconds_to_units).
        with(90210.5, foo: 'bar').
        and_return({
          :days => 2,
          :minutes => 5,
          :spinachios => 42
        })
      expect(described_class.seconds_to_units_in_words(90210.5, foo: 'bar')).
        to eq("2 days, 5 minutes, 42 spinachios")
    end
  end
end