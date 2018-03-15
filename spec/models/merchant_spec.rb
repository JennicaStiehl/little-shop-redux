RSpec.describe Merchant do
  before :each do
    DatabaseCleaner.clean
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe 'Validate fields' do
    it 'should require a name' do
      merchant = Merchant.new

      expect(merchant).to_not be_valid
    end
  end

  describe 'Class methods' do
    it 'should be able to create a merchant' do
      merchant = Merchant.create(name: 'Bob')

      expect(merchant).to be_valid
      expect(Merchant.all.length).to be(1)

      Merchant.create(name: 'Joe')
      expect(Merchant.all.length).to be(2)
    end

    it 'should be able to read a merchant' do
      Merchant.create(name: 'Bob')
      Merchant.create(name: 'Joe')

      merchant = Merchant.find_by(name: 'Bob')
      expect(merchant.name).to eq('Bob')
    end

    it 'should be able to update a merchant' do
      Merchant.create(name: 'Bob')

      merchant = Merchant.find_by(name: 'Bob')
      merchant.update(name: 'Joe')

      expect(Merchant.first.name).to eq('Joe')
    end

    it 'should be able to delete a merchant' do
      Merchant.create(name: 'Bob')

      expect(Merchant.all.length).to be(1)
      Merchant.find_by(name: 'Bob').delete

      expect(Merchant.all.length).to be(0)
    end
  end
end