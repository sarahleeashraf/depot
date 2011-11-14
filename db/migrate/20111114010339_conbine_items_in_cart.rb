class ConbineItemsInCart < ActiveRecord::Migration
  def up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      p sums      

      sums.each do |product_id, quantity|
        puts "product id: " + product_id.to_s
        puts "quantity: " + quantity.to_s
       
        if quantity > 1

          puts "removing individual items"
          # remove individual items
          cart.line_items.where(:product_id => product_id).delete_all
          
	  puts "adding single item"
          # replace with a single item
          cart.line_items.create(:product_id => product_id, :quantity => quantity)
        end 
      end
    end

  end

  def down
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
      end

      # remove original item
      line_item.destroy
    end
  end
end
