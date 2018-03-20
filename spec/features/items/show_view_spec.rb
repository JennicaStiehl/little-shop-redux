RSpec.describe LittleShopApp do
  describe 'paths' do
    before(:each) do
      DatabaseCleaner.clean
      Merchant.create(name: 'Test Merchant')
      Item.create(title: 'Test Item',
                  description: 'description',
                  price: 1000,
                  image: 'link',
                  merchant_id: 1)

    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe 'item show view' do
      it 'should have the merchants info' do
        visit '/items/1'

        expect(page).to have_content('Test Merchant')
      end

      it 'should have an edit and delete button' do
        visit '/items/1'

        expect(page).to have_selector :css, 'a.button.edit'
        expect(page).to have_selector :css, '.button.button.delete'
      end

      it 'should go to the edit page when edit is clicked' do
        visit '/items/1'

        click_on 'Edit'

        expect(current_path).to eq '/items/1/edit'
      end

      it 'should delete the item when delete is clicked' do
        visit '/items/1'

        click_on 'Delete'

        expect(current_path).to eq '/items'
        expect(page).not_to have_content 'Test Item'
      end

      it 'should go to the merchant when the merchants name is clicked' do
        visit '/items/1'

        click_on 'Test Merchant'

        expect(current_path).to be '/merchants/1'
      end

      it 'should have the item info' do
        visit '/items/1'

        expect(page).to have_content 'Test Item'
        expect(page).to have_content '$10.00'
        expect(page).to have_content 'description'
      end
    end
  end
end