require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  
  test "who_bought works for xml info" do
    get :who_bought, :id => products(:one).id
    product = assigns(:product)
    
    assert_response :success
    assert_match /<title>#{product.title}<\/title>/, @response.body
    assert_match /<description>#{product.description}/, @response.body
    assert_match /<name>#{product.orders.first.name}<\/name>/, @response.body
    assert_match /<address>#{product.orders.first.address}/, @response.body
  end
  
  test "who_bought works for json info" do
    get :who_bought, :id => products(:one).id, :format => "json"
    product = assigns(:product)
    
    assert_response :success
    response = ActiveSupport::JSON.decode(@response.body)
    assert_equal product.title, response["product"]["title"]
    assert_equal product.price, response["product"]["price"]
    assert_equal product.orders.first.email, response["product"]["orders"].first["email"]
    assert_equal product.orders.first.pay_type, response["product"]["orders"].first["pay_type"]
  end

end
