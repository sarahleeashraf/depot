class StoreController < ApplicationController
  
  def index
    @now = Time.new
    @products = Product.order(:title)


    if session[:store_counter].nil?
      session[:store_counter] = 1
    else
      session[:store_counter] += 1
    end

    @store_counter = session[:store_counter]
  end

end
