require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  test "the truth" do
    assert true
  end

  test "cart has no attributes" do
    cart = Cart.new

    assert cart.valid?
  end

  test "adding a duplicate product to a cart does not add a new line item" do
    cart = Cart.new

    cart.add_product(products(:ruby).id)
    cart.save!
    cart.add_product(products(:ruby).id)

    assert (cart.line_items.length == 1)
  end

  test "adding a new product to the cart adds a new line item" do
    cart = cart.new

    cart.add_product(products(:ruby).id)
    cart.save!
    cart.add_product(products(:one).id)

    assert (cart.line_items.length == 2)
  end

end
