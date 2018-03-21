RSpec.describe Item do

  before :each do
    DatabaseCleaner.clean
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe 'Validate fields' do
    it 'is invalid to not have a title' do
      item = Item.new(description: 'description',
                      price: 1,
                      image: 'link')
      expect(item).to_not be_valid
    end
    it 'is invalid to not have a description' do
      item = Item.new(title: '',
                      price: 1,
                      image: 'link')
      expect(item).to_not be_valid
    end
    it 'is invalid to not have a price' do
      item = Item.new(title: '',
                      description: 'description',
                      image: 'link')
      expect(item).to_not be_valid
    end
    it 'is invalid to not have an image' do
      item = Item.new(title: '',
                      description: 'description',
                      price: 1)
      expect(item).to_not be_valid
    end
  end

  describe 'Class methods' do
    it 'should be able to create an item' do
      item = Item.create(title: 'Foo',
                         description: 'Bar',
                         price: 1,
                         image: 'image')

      expect(item).to be_valid
      expect(Item.all.length).to be(1)

      Item.create(title: 'Bar',
                  description: 'Foo',
                  price: 1,
                  image: 'image')
      expect(Item.all.length).to be(2)
    end

    it 'should be able to read an item' do
      Item.create(title: 'Foo',
                  description: 'Bar',
                  price: 1,
                  image: 'image')
      Item.create(title: 'Bar',
                  description: 'Foo',
                  price: 1,
                  image: 'image')

      item = Item.find_by(title: 'Foo')
      expect(item.description).to eq('Bar')
    end

    it 'should be able to update an item' do
      Item.create(title: 'Foo',
                  description: 'Bar',
                  price: 1,
                  image: 'image')

      item = Item.find_by(title: 'Foo')
      item.update(title: 'Bar')

      expect(Item.first.title).to eq('Bar')
    end

    it 'should be able to delete an item' do
      Item.create(title: 'Foo',
                  description: 'Bar',
                  price: 1,
                  image: 'image')

      expect(Item.all.length).to be(1)
      Item.find_by(title: 'Foo').delete

      expect(Item.all.length).to be(0)
    end

    it 'should be able to format a price' do
      item = Item.create(title: 'Foo',
                  description: 'Bar',
                  price: 1234,
                  image: 'image')
      expect(item.formatted_price).to eq('$12.34')


      item = Item.create(title: 'Foo',
                  description: 'Bar',
                  price: 123456,
                  image: 'image')
      expect(item.formatted_price).to eq('$1,234.56')
    end

    it 'should be able to get average price of items as formatted string' do
      Item.create(title: 'Foo',
                  description: 'Bar',
                  price: 1234,
                  image: 'image')
      Item.create(title: 'Foo',
                  description: 'Bar',
                  price: 123456,
                  image: 'image')

      expect(Item.avg_price).to eq('$623.45')
    end
  end
end
