# Defines LittleShop
class LittleShopApp < Sinatra::Base
  set :public_folder, 'public'

  get '/merchants' do
    @merchants = Merchant.all
    erb :"merchants/index"
  end

  get '/items' do
    @items = Item.all
    erb :'items/index', layout: :index_layout
  end

  get '/items/:id' do
    @item = Item.find(params[:id])
    erb :'items/show'
  end
end
