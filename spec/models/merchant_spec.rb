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

    it 'should return merchant that has most items' do
      Merchant.create(name: 'Test Merchant')
      Merchant.create(name: 'Merchant 2')
      Item.create(merchant_id: 1,
                  title: 'Test Item',
                  description: 'description',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 1,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 2,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 200,
                  image: 'link')

      merchant = Merchant.most_items
      expect(merchant.name).to eq 'Test Merchant'
    end

    it 'should return merchant that has highest total item cost' do
      Merchant.create(name: 'Test Merchant')
      Merchant.create(name: 'Merchant 2')
      Item.create(merchant_id: 1,
                  title: 'Test Item',
                  description: 'description',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 1,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 2,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 200,
                  image: 'link')

      merchant = Merchant.highest_cost
      expect(merchant.name).to eq 'Merchant 2'
    end

    it 'should return a count of merchant items' do
      Merchant.create(name: 'Test Merchant')
      Merchant.create(name: 'Merchant 2')
      Item.create(merchant_id: 1,
                  title: 'Test Item',
                  description: 'description',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 1,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 2,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 200,
                  image: 'link')

      merchant_one = Merchant.find(1)
      expect(merchant_one.item_count).to eq 2

      merchant_two = Merchant.find(2)
      expect(merchant_two.item_count).to eq 1
    end

    it 'should return an avg of merchant item prices' do
      Merchant.create(name: 'Test Merchant')
      Merchant.create(name: 'Merchant 2')
      Item.create(merchant_id: 1,
                  title: 'Test Item',
                  description: 'description',
                  price: 5,
                  image: 'link')
      Item.create(merchant_id: 1,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 2,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 200,
                  image: 'link')

      merchant = Merchant.find(1)
      expect(merchant.avg_item_price).to eq 3
    end

    it 'should return an total of merchant item prices' do
      Merchant.create(name: 'Test Merchant')
      Merchant.create(name: 'Merchant 2')
      Item.create(merchant_id: 1,
                  title: 'Test Item',
                  description: 'description',
                  price: 5,
                  image: 'link')
      Item.create(merchant_id: 1,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 1,
                  image: 'link')
      Item.create(merchant_id: 2,
                  title: 'Test 2',
                  description: 'description 2',
                  price: 200,
                  image: 'link')

      merchant = Merchant.find(1)
      expect(merchant.total_cost).to eq 6

      merchant_two = Merchant.find(2)
      expect(merchant_two.total_cost).to eq 200
    end
  end
end
