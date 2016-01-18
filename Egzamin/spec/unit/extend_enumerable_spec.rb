describe Enumerable do
  describe "#sum" do
    let(:to_ten) { (1..10).to_a }
    let(:from_20) { (20..100).to_a }

    it "returns sum of numbers from 1 to 10" do
      expect(to_ten.sum).to eq(55)
    end

    it "returns sum of numbers from 20 to 100" do
      expect(from_20.sum).to eq(4860  )
    end


  end
end
