# Defines LittleShop
class LittleShopApp < Sinatra::Base
  get '/merchants' do
    @merchants = Merchant.all
    erb :"merchants/index"
  end
end
