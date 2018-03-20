RSpec.describe LittleShopApp do
  describe 'paths' do
    before(:each) do
      DatabaseCleaner.clean
      Merchant.create(name: 'Test Merchant')
      Item.create(title: 'Test Item',
                  description: 'description',
                  price: 1,
                  image: 'link',
                  merchant_id: 1)
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe 'merchant paths' do
      it 'should have a success code for GET /merchants' do
        visit '/merchants'
        expect(page.status_code).to  eq 200
      end

      it 'should have a success code for GET /merchants/:id' do
        visit '/merchants/1'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /merchants/new' do
        visit '/merchants/new'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /merchants/:id/edit' do
        visit '/merchants/1/edit'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /merchants/:id/edit' do
        visit '/merchants/1/edit'
        expect(page.status_code).to eq 200
      end
    end

    describe 'item paths' do
      it 'should have a success code for GET /items' do
        visit '/items'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /items/:id' do
        visit '/items/1'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /items/new' do
        visit '/items/new'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /items/:id/edit' do
        visit '/items/1/edit'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /items/:id/edit' do
        visit '/items/1/edit'
        expect(page.status_code).to eq 200
      end
    end
  end
end
