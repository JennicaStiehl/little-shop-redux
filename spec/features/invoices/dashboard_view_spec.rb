RSpec.describe 'Invoice dashboard' do
  before(:all) do
    DatabaseCleaner.clean
    Invoice.create(merchant_id: 1, status: 'shipped')
    Invoice.create(merchant_id: 1, status: 'shipped')
    Invoice.create(merchant_id: 1, status: 'shipped')
    Invoice.create(merchant_id: 1, status: 'shipped')
    Invoice.create(merchant_id: 1, status: 'shipped')
    Invoice.create(merchant_id: 1, status: 'shipped')
    Invoice.create(merchant_id: 1, status: 'shipped')
    Invoice.create(merchant_id: 1, status: 'pending')
    Invoice.create(merchant_id: 1, status: 'returned')
    Invoice.create(merchant_id: 1, status: 'pending')

    InvoiceItem.create(item_id: 1,invoice_id: 1,quantity: 2,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 1,quantity: 1,unit_price: 2000)
    InvoiceItem.create(item_id: 3,invoice_id: 1,quantity: 2,unit_price: 3000)

    InvoiceItem.create(item_id: 1,invoice_id: 2,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 2,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 3,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 3,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 4,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 1,invoice_id: 4,quantity: 1,unit_price: 1000)

    InvoiceItem.create(item_id: 1,invoice_id: 5,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 1,invoice_id: 5,quantity: 1,unit_price: 1000)

    InvoiceItem.create(item_id: 1,invoice_id: 6,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 6,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 2,invoice_id: 7,quantity: 1,unit_price: 2000)
    InvoiceItem.create(item_id: 2,invoice_id: 7,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 2,invoice_id: 8,quantity: 1,unit_price: 2000)
    InvoiceItem.create(item_id: 2,invoice_id: 8,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 9,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 9,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 10,quantity: 1,unit_price: 1000)
  end

  after(:all) do
    DatabaseCleaner.clean
  end
end