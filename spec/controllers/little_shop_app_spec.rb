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
      Invoice.create(merchant_id: 1, status: 'shipped')
      InvoiceItem.create(item_id: 1,invoice_id: 1,quantity: 1,unit_price: 1000)
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe 'error path' do
      it 'should display the error page on 404' do
        visit '/non_existent_page'

        expect(page.status_code).to eq 404
        expect(page).to have_content 'An error was encountered'
        expect(page).to have_content '404 - The page you requested was not found'
      end
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

      it 'should have a success code for GET /merchants-dashboard' do
        Merchant.create(name: 'Merchant')
        Item.create(merchant_id: 1,
                    title: 'Test Item',
                    description: 'description',
                    price: 1,
                    image: 'link')
        visit '/merchants-dashboard'
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

      it 'should have a success code for GET /items-dashboard' do
        visit '/items-dashboard'
        expect(page.status_code).to eq 200
      end
    end

    describe 'invoice paths' do
      it 'should have a success code for GET /invoices' do
        visit '/invoices'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /invoices/:id' do
        visit '/invoices/1'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /invoices/:id/edit' do
        visit '/invoices/1/edit'
        expect(page.status_code).to eq 200
      end

      it 'should have a success code for GET /invoices-dashboard' do
        visit '/invoices-dashboard'
        expect(page.status_code).to eq 200
      end
    end
  end
end
