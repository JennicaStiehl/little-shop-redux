RSpec.describe 'Invoices show view' do
  before(:each) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')
    Item.create(merchant_id: 1,
                title: 'Test item 1',
                description: 'description',
                price: 1000,
                image: 'link')
    Item.create(merchant_id: 1,
                title: 'Test item 2',
                description: 'description 2',
                price: 1500,
                image: 'link')

    Invoice.create(merchant_id: 1, status: 'pending')

    InvoiceItem.create(
                  item_id: 1,
                  invoice_id: 1,
                  quantity: 2,
                  unit_price: 1000
                )
    InvoiceItem.create(
                  item_id: 2,
                  invoice_id: 1,
                  quantity: 2,
                  unit_price: 1500
                )
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have the invoice ID and status' do
      visit '/invoices/1'

      expect(page).to have_content('Invoice: 1 - Pending')
    end
  end
end