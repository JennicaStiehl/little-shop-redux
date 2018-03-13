RSpec.describe Merchant do
  before :all do
    DatabaseCleaner.clean
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe 'Validate fields' do
    it 'should require a name' do
      merchant = Merchant.new

      expect(merchant).to_not be_valid
    end
  end
end