describe 'Exchange money' do
  context 'valid params' do
    context 'for currency outside the file' do
      let(:m) { Money.new(10, 'EUR')}
      subject { Exchange.new(m, 'RUB').call }

      it 'raise error if not found currency in file' do
        expect { subject }.to  raise_error(NoMethodError)
      end
    end

    context 'for currency from file' do
      let(:m) { Money.new(10, 'EUR')}
      subject{ Exchange.new(m, 'PLN').call }

      it 'return recalculated value' do
        expect( subject.to_s ).to eq("42.20 PLN")
      end
    end
  end

end
