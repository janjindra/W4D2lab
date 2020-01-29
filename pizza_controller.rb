require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza_order.rb')
also_reload('./models/*')


#This controller will retrun some HTML that shows all of the pizza orders in a nice list.
get '/pizza-orders' do
  #we first need to get all the pizza orders: 1) require_relative, 2) sql query.
  #then we will pass the pizza orders into a @global variable
@orders = PizzaOrder.all() #call method all is used here from pizza_order.rb
  #render the index route to html.
erb(:index)
end

#This route should return html page that has a form to create a new pizza order.
get '/pizza-orders/new' do
  erb(:new)
end


# This route should return some html that shows a single pizza order.
get '/pizza-orders/:id' do
#first, grab the order id from the URL
order_id = params[:id] #saving the user's inserted id to a local variable oder_id
#get pizza order - by calling find on PizzaOrder and by passing in the id we've got from params.
@order = PizzaOrder.find(order_id)
#render the show route for that order
erb(:show)
end

#This route should accept POST requests on pizza-orders
# then take the posts as parameters
# then create a new pizza order
post '/pizza-orders' do
  @order = PizzaOrder.new(params)#params here are all the inputs a user typed in to the form on the website
  @order.save()
erb(:create)
end



##======

get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

post '/pizza-orders/:id' do
@order = PizzaOrder.new(params)  #??????
@order.update()
erb(:update)
end


#=====
post '/pizza-orders/:id/delete' do
@order = PizzaOrder.find(params[:id])
@order.delete()
erb(:delete)
#redirect "/pizza-orders"
end
