# Defines LittleShop
class LittleShopApp < Sinatra::Base
  get '/merchants' do
    @merchants = Merchant.all
    erb :"merchants/index"
  end

  get '/items' do
    @items = Item.all_items
    erb :'items/index'
  end
end
