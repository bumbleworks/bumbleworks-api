describe Bumbleworks::Api::Presenter do
  describe ".from_array" do
    it "maps each object to its presentation, passing in_collection arg" do
      allow(described_class).to receive(:new).
        with(:a, :in_collection => true).
        and_return(:a_p)
      allow(described_class).to receive(:new).
        with(:b, :in_collection => true).
        and_return(:b_p)
      expect(described_class.from_array([:a, :b])).to eq(
        [:a_p, :b_p]
      )
    end
  end

  describe ".present" do
    it "instantiates single presenter if not given array" do
      allow(described_class).to receive(:new).with(:a).and_return(:a_p)
      expect(described_class.present(:a)).to eq(:a_p)
    end

    it "returns result of .from_array if given array" do
      allow(described_class).to receive(:from_array).
        with([:a, :b]).
        and_return(:presented_array)
      expect(described_class.present([:a, :b])).to eq(:presented_array)
    end
  end
end