RSpec.describe LittleShopApp do
  describe 'paths' do
    before(:each) do
      DatabaseCleaner.clean
      Item.create(title: 'Test Item',
                  description: 'description',
                  price: 1,
                  image: 'link',
                  merchant_id: 1)
      Merchant.create(name: 'Test Merchant')
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    describe 'merchant show view' do
      it 'should have the merchants info' do
        visit '/merchants/1'

        expect(page).to have_content('Test Merchant')
      end

      it 'should have an edit and delete button' do
        visit '/merchants/1'

        expect(page).to have_selector :css, 'a.button.edit'
        expect(page).to have_selector :css, '.button.button.delete'
      end

      it 'should go to the edit page when edit is clicked' do
        visit '/merchants/1'

        click_on 'Edit'

        expect(current_path).to eq '/merchants/1/edit'
      end

      it 'should delete the merchant when delete is clicked' do
        visit '/merchants/1'

        click_on 'Delete'

        expect(current_path).to eq '/merchants'
        expect(page).not_to have_content 'Test Merchant'
      end

      it 'should have the merchants items' do
        visit '/merchants/1'

        expect(page).to have_content 'Test Item'
      end
    end
  end
end