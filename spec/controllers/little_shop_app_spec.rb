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
      get '/merchants'

      it 'should respond with a success code' do
        expect(last_response.status).to  eq 200
      end

      it 'should get all merchants' do
        expect(last_response.body).to include ''
      end
    end

    describe 'GET /items' do
      get '/items'

      it 'should respond with success code' do
        expect(last_response.status).to eq 200
      end
    end

    describe 'GET /item/:id' do
      get '/items/1'

      it 'should respond with success code' do
        expect(last_response.status).to eq 200
      end
    end

    describe 'GET /item/new' do
      get '/items/new'

      it 'should respond with success code' do
        expect(last_response.status).to eq 200
      end
    end
  end
end
