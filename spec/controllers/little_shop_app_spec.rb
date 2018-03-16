RSpec.describe LittleShopApp do
  describe 'paths' do
    before(:each) do
      DatabaseCleaner.clean
      Item.create(title: 'Test Item',
                  description: 'description',
                  price: 1,
                  image: 'link')
      Merchant.create(name: 'Test Merchant')
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe 'GET /merchants' do

      it 'should respond with a success code' do
        visit '/merchants'
        expect(page.status_code).to  eq 200
      end
    end

    describe 'GET /items' do

      it 'should respond with success code' do
        visit '/items'
        expect(page.status_code).to eq 200
      end
    end

    describe 'GET /item/:id' do

      it 'should respond with success code' do
        visit '/items/1'
        expect(page.status_code).to eq 200
      end
    end

    describe 'GET /item/new' do

      it 'should respond with success code' do
        visit '/items/1/new'
        expect(page.status_code).to eq 200
      end
    end
  end
end
