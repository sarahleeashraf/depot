class AddPriceToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :total_price, :decimal
    
    LineItem.all.each do |line_item|
      product = Product.find(line_item.product_id)
      line_item.total_price = line_item.quantity * product.price
      line_item.save!
    end    
  end
end
