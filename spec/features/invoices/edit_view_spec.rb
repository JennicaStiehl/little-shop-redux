RSpec.describe 'Invoices edit view' do
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
      visit '/invoices/1/edit'

      expect(page).to have_content('Invoice: 1 - Pending')
    end

    it 'should have a form content' do
      visit '/invoices/1/edit'
      expect(find('[name="invoice[merchant_id]"]').value).to eq('1')
      expect(find('[name="invoice[status]"]').value).to eq('pending')
    end

    context 'item table' do
      it 'should have a header' do
        visit '/invoices/1/edit'

        expect(page).to have_selector('table.items')
        within('table.items') do
          expect(page).to have_selector('thead')

          within('thead') do
            expect(page).to have_content('Item ID')
            expect(page).to have_content('Quantity')
          end
        end
      end

      it 'should have a list of items' do
        visit '/invoices/1/edit'

        expect(page).to have_selector('table.items tbody')
        within('table.items tbody') do
          expect(all('tr').length).to be(2)

          within('tr:first-child') do
            expect(page).to have_content('1')
            expect(page).to have_content('Test item 1')
            expect(page).to have_content('2')
            expect(page).to have_content('$10.00')
          end
        end
      end
    end
  end

  describe 'functionality' do
    it 'should be able to edit the invoice status' do
      visit '/invoices/1/edit'

      select('Returned', :from => 'invoice[status]')

      click_on 'Update Invoice'

      expect(current_path).to eq '/invoices/1'

      expect(page).to have_content('Invoice 1 - Returned')
    end

    it 'should be able to cancel the edit' do
      visit '/invoices/1/edit'

      click_on 'Cancel'

      expect(current_path).to eq '/invoices'
    end

    it 'should be able to click on an item' do
      visit '/invoices/1/edit'

      find('tbody tr:first-child td:first-child a').click

      expect(current_path).to eq '/items/1'
    end
  end
end