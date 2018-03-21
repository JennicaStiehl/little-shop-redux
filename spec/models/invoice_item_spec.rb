RSpec.describe InvoiceItem do
  before :each do
    DatabaseCleaner.clean
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe 'Validate fields' do
    it 'should require an invoice_id' do
      invoice_item = InvoiceItem.new(item_id: 1,
                                     quantity: 1,
                                     unit_price: 1)

      expect(invoice_item).to_not be_valid
    end

    it 'should require an item_id' do
      invoice_item = InvoiceItem.new(invoice_id: 1,
                                     quantity: 1,
                                     unit_price: 1)

      expect(invoice_item).to_not be_valid
    end

    it 'should require a quantity' do
      invoice_item = InvoiceItem.new(invoice_id: 1,
                                     item_id: 1,
                                     unit_price: 1)

      expect(invoice_item).to_not be_valid
    end

    it 'should require a unit_price' do
      invoice_item = InvoiceItem.new(invoice_id: 1,
                                     item_id: 1,
                                     quantity: 1)

      expect(invoice_item).to_not be_valid
    end
  end

  describe 'Class methods' do
    it 'should be able to create an invoice item' do
      invoice_item = InvoiceItem.create(invoice_id: 12,
                                        item_id: 34,
                                        quantity: 1,
                                        unit_price: 50)

      expect(invoice_item).to be_valid
      expect(InvoiceItem.all.length).to be(1)

      InvoiceItem.create(invoice_id: 12,
                         item_id: 34,
                         quantity: 1,
                         unit_price: 50)
      expect(InvoiceItem.all.length).to be(2)
    end

    it 'should be able to read an invoice item' do
      InvoiceItem.create(invoice_id: 12,
                         item_id: 34,
                         quantity: 1,
                         unit_price: 50)
      InvoiceItem.create(invoice_id: 13,
                         item_id: 4,
                         quantity: 1,
                         unit_price: 50)
      invoice_item = InvoiceItem.find_by(invoice_id: 12)
      expect(invoice_item.item_id).to eq(34)
    end

    it 'should be able to update an invoice item' do
      InvoiceItem.create(invoice_id: 12,
                         item_id: 4,
                         quantity: 1,
                         unit_price: 50)
      invoice_item = InvoiceItem.find_by(invoice_id: 12)
      invoice_item.update(quantity: 4)

      expect(InvoiceItem.first.quantity).to eq(4)
    end

    it 'should be able to delete an invoice item' do
      InvoiceItem.create(invoice_id: 12,
                         item_id: 4,
                         quantity: 1,
                         unit_price: 50)

      expect(InvoiceItem.all.length).to be(1)
      InvoiceItem.find_by(invoice_id: 12).delete

      expect(InvoiceItem.all.length).to be(0)
    end

    it 'should be able to format a price' do
      item = InvoiceItem.create(invoice_id: 12,
                                item_id: 4,
                                quantity: 1,
                                unit_price: 1234
                               )
      expect(item.formatted_price).to eq('$12.34')


      item = InvoiceItem.create(invoice_id: 12,
                                item_id: 4,
                                quantity: 1,
                                unit_price: 123456
                               )
      expect(item.formatted_price).to eq('$1,234.56')
    end
  end
end
