RSpec.describe Merchant do
  describe 'Validate fields' do
    it 'should require a name' do
      merchant = Merchant.new

      expect(merchant).to_not be_valid
    end
  end
end