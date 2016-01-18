class Account
  attr_reader :balance, :name, :last_name, :account_number

  def initialize(options)
    @name ||= options[:name]
    @last_name ||= options[:last_name]
    check_existing_account_number(options)
    @account_number ||= options[:account_number]
    @balance ||= options[:balance] # array of Money's instances
  end

  def group_by_currency
    @balance.group_by(&:currency)
  end

  def normalize
    temp_arry = []
    group_by_currency.values.each do |arry|
      temp_arry.push arry.inject(&:+)
    end
    temp_arry
  end

  private
  def check_existing_account_number(params)
    raise ArgumentError.new("Lack of account number") if params[:account_number].nil?
  end



end
