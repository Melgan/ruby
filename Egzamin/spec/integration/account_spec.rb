describe Account do
  describe "#new" do
    let(:options) { {name: "Jan", last_name: "Nowak", account_number: "567434786975",
      balance: [double('Money'), double('Money'), double('Money')] } }

    it "raises error when initialized without parameters" do
      expect { Account.new }.to raise_error(ArgumentError)
    end

    it "can be initalized by hash and doesn't raise error" do
      expect { Account.new(options) }.to_not raise_error
    end

    it "cannot be initialized without account_number and raises error" do
      expect { Account.new({name: "John", last_name: "Newman"}) }.to raise_error
    end
  end

  describe "#group_by_currency" do
    context "returns amount of currencies" do
      let(:two_currencies) { Account.new({name: "Jan", last_name: "Nowak", account_number: "567434786975",
        balance: [Money.new('12.32', 'PLN'), Money.new('123.23', 'USD')] }) }

      let(:three_currencies) { Account.new({name: "Jan", last_name: "Nowak", account_number: "567434786975",
    balance: [Money.new('12.32', 'PLN'), Money.new('123.23', 'USD'), Money.new("695.21", 'PLN'), Money.new("963.21", 'USD'), Money.new('12', 'RUB') ]}) }


      it "groups elements by their currencies" do
        expect(two_currencies.group_by_currency.size).to eq(2)
      end

      it "groups elements by their currencies" do
        expect(three_currencies.group_by_currency.size).to eq(3)
      end

    end
  end

  describe "#normalize" do
    context "group by currency and normalize arrays of this same currency" do
      let(:two_currencies) { Account.new({account_number: "567434786975", balance: [Money.new('12.32', 'PLN'),
        Money.new('123.23', 'USD')] }) }
      let(:three_currencies) { Account.new({account_number: "567434786975", balance: [Money.new('12.32', 'PLN'),
        Money.new('123.23', 'USD'), Money.new("695.21", 'PLN'), Money.new("963.21", 'USD'), Money.new('12', 'RUB'),
        Money.new('12', 'RUB') ]}) }

      it "counts sum of this same currency and should return array of two elements" do
        expect(two_currencies.normalize.size).to eq(2)
      end

      it "counts a sum of this same currency and should return array of three elements" do
        expect(three_currencies.normalize.size).to eq(3)
      end
    end
  end


  describe "#name" do
    let(:owner) { double("Account", name: "John" )}
    it "returns the name of the account owner" do
      expect(owner.name).to eq "John"
    end
  end


  describe "#last_name" do
    let(:owner) { double("Account", last_name: "Smith")}

    it "returns the last name of the account owner" do
      expect(owner.last_name).to eq "Smith"
    end
  end

end
