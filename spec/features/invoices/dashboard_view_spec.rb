RSpec.describe 'Invoice dashboard' do
  before(:all) do
    DatabaseCleaner.clean
    Merchant.create(name: 'Test Merchant')

    Item.create(title: 'Test Item 1', description: 'test', price: 1, image: 'a')
    Item.create(title: 'Test Item 2', description: 'test', price: 1, image: 'a')
    Item.create(title: 'Test Item 3', description: 'test', price: 1, image: 'a')

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
    InvoiceItem.create(item_id: 3,invoice_id: 1,quantity: 2,unit_price: 5000)

    InvoiceItem.create(item_id: 1,invoice_id: 2,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 2,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 3,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 3,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 4,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 1,invoice_id: 4,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 5,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 1,invoice_id: 5,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 6,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 6,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 2,invoice_id: 7,quantity: 1,unit_price: 2000)
    InvoiceItem.create(item_id: 2,invoice_id: 7,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 2,invoice_id: 8,quantity: 1,unit_price: 3000)

    InvoiceItem.create(item_id: 1,invoice_id: 9,quantity: 1,unit_price: 1000)
    InvoiceItem.create(item_id: 2,invoice_id: 9,quantity: 1,unit_price: 2000)

    InvoiceItem.create(item_id: 1,invoice_id: 10,quantity: 2,unit_price: 1000)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe 'content' do
    it 'should have cards' do
      visit '/invoices-dashboard'

      expect(page).to have_selector('.card')
      expect(all('.card').length).to be(3)
    end

    it 'should have status percentages' do
      visit '/invoices-dashboard'

      within('.card:first-child') do
        within('li:first-child') do
          expect(page).to have_content 'Pending 20%'
        end
        within('li:nth-child(2)') do
          expect(page).to have_content 'Shipped 70%'
        end
        within('li:last-child') do
          expect(page).to have_content 'Returned 10%'
        end
      end
    end

    it 'should have unit prices' do
      visit '/invoices-dashboard'
      
      within('.card:nth-child(2)') do
        within('#highest') do
          expect(page).to have_content 'Highest'

          expect(page).to have_content 'Invoice: 1'

          find('a').click
          expect(current_path).to eq('/invoices/1')
        end

        within('#lowest') do
          expect(page).to have_content 'Lowest'

          expect(page).to have_content 'Invoice: 10'

          find('a').click
          expect(current_path).to eq('/invoices/10')
        end
      end
    end

    it 'should have quantities' do
      within('.card:last-child') do
        within('#highest') do
          expect(page).to have_content 'Highest'

          expect(page).to have_content 'Invoice: 1'

          find('a').click
          expect(current_path).to eq('/invoices/1')
        end

        within('#lowest') do
          expect(page).to have_content 'Lowest'

          expect(page).to have_content 'Invoice: 8'

          find('a').click
          expect(current_path).to eq('/invoices/8')
        end
      end
    end
  end
end