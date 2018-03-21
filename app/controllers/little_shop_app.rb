# Defines LittleShop
class LittleShopApp < Sinatra::Base
  set :public_folder, 'public'

  get '/items' do
    erb :'items/index', locals: { items: Item.all }
  end

  get '/items/new' do
    erb :'items/new', locals: { merchants: Merchant.all }
  end

  post '/items' do
    Item.create(params[:item])

    redirect '/items'
  end

  delete '/items/:id' do
    Item.destroy(params[:id])

    redirect '/items'
  end

  get '/items/:id' do
    erb :'items/show', locals: { item: Item.find(params[:id]) }
  end

  get '/items/:id/edit' do
    erb :'items/edit', locals: { item: Item.find(params[:id]),
                                 merchants: Merchant.all }
  end

  put '/items/:id' do
    Item.find(params[:id]).update(params[:item])

    redirect "/items/#{params[:id]}"
  end

  get '/items-dashboard' do
    erb :'items/dashboard'
  end

  get '/merchants' do
    erb :'merchants/index',
        locals: { merchants: Merchant.all }
  end

  get '/merchants/new' do
    erb :'merchants/new'
  end

  post '/merchants' do
    Merchant.create(params[:merchant])

    redirect '/merchants'
  end

  delete '/merchants/:id' do
    Merchant.destroy(params[:id])

    redirect '/merchants'
  end

  get '/merchants/:id' do
    erb :'merchants/show', locals: { merchant: Merchant.find(params[:id]) }
  end

  get '/merchants/:id/edit' do
    erb :'merchants/edit', locals: { merchant: Merchant.find(params[:id]) }
  end

  put '/merchants/:id' do
    Merchant.find(params[:id]).update(params[:merchant])

    redirect "/merchants/#{params[:id]}"
  end

  get '/merchants-dashboard' do
    erb :'merchants/dashboard', locals: { merchants: Merchant.all,
                                          item_merch: Merchant.most_items,
                                          price_merch: Merchant.highest_cost }
  end

  get '/invoices' do
    erb :'invoices/index',
        locals: { invoices: Invoice.all }
  end

  # get '/invoices/new' do
  #   erb :'invoices/new', locals: { merchants: Merchant.all }
  # end

  post '/invoices' do
    Invoice.create(params[:invoice])

    redirect '/invoices'
  end

  delete '/invoices/:id' do
    Invoice.destroy(params[:id])

    redirect '/invoices'
  end

  get '/invoices/:id' do
    erb :'invoices/show', locals: { invoice: Invoice.find(params[:id]) }
  end

  get '/invoices/:id/edit' do
    erb :'invoices/edit', locals: { invoice: Invoice.find(params[:id]) }
  end

  put '/invoices/:id' do
    Invoice.find(params[:id]).update(params[:invoice])

    redirect "/invoices/#{params[:id]}"
  end

  get '/invoices-dashboard' do
    erb :'invoices/dashboard',
        locals: {
          percentages: Invoice.status_percentages,
          prices: Invoice.price_high_low,
          quantity: Invoice.quantity_high_low
        }
  end
end
