def setup_invoices
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

  InvoiceItem.create(item_id: 2,invoice_id: 8,quantity: 1,unit_price: 3000)

  InvoiceItem.create(item_id: 1,invoice_id: 9,quantity: 1,unit_price: 1000)
  InvoiceItem.create(item_id: 2,invoice_id: 9,quantity: 1,unit_price: 2000)

  InvoiceItem.create(item_id: 1,invoice_id: 10,quantity: 2,unit_price: 1000)
end

RSpec.describe Invoice do
  before :each do
    DatabaseCleaner.clean
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe 'Validate fields' do
    it 'should require a merchant_id' do
      invoice = Invoice.new(status: 'pending')

      expect(invoice).to_not be_valid
    end

    it 'should require a status' do
      invoice = Invoice.new(merchant_id: 1)

      expect(invoice).to_not be_valid
    end
  end

  describe 'Class methods' do
    it 'should be able to create an invoice' do
      invoice = Invoice.create(customer_id: 1,
                               merchant_id: 1,
                               status: 'pending')

      expect(invoice).to be_valid
      expect(Invoice.all.length).to be(1)

      Invoice.create(customer_id: 1,
                     merchant_id: 2,
                     status: 'pending')
      expect(Invoice.all.length).to be(2)
    end

    it 'should be able to read an invoice' do
      Invoice.create(customer_id: 1,
                     merchant_id: 2,
                     status: 'pending')
     Invoice.create(customer_id: 1,
                    merchant_id: 2,
                    status: 'shipped')

      invoice = Invoice.find_by(status: 'shipped')
      expect(invoice.merchant_id).to eq(2)
    end

    it 'should be able to update an invoice' do
      Invoice.create(customer_id: 1,
                     merchant_id: 2,
                     status: 'pending')

      invoice = Invoice.find_by(status: 'pending')
      invoice.update(status: 'shipped')

      expect(Invoice.first.status).to eq('shipped')
    end

    it 'should be able to delete an invoice' do
      Invoice.create(customer_id: 1,
                     merchant_id: 2,
                     status: 'pending')

      expect(Invoice.all.length).to be(1)
      Invoice.find_by(customer_id: 1).delete

      expect(Invoice.all.length).to be(0)
    end

    it 'should be able to get status percentages' do
      expected = {
        pending: 20,
        shipped: 70,
        returned: 10
      }

      setup_invoices

      expect(Invoice.status_percentages).to eq(expected)
    end

    it 'should be able to get highest/lowest total unit price' do
      setup_invoices

      result = Invoice.price_high_low

      expect(result[:highest].id).to be(1)
      expect(result[:lowest].id).to be(10)
    end
  end
end