require 'test_helper'

class Api::V1::CustomersController::SearchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @customers = create_list(:customer, 3)
  end

  test "can find customer by first name parameter case insensitive match" do
    desired_customer = @customers[2]

    get "/api/v1/customers/find?first_name=#{desired_customer.first_name.upcase}"

    result = JSON.parse(response.body)

    assert_response :success
    assert_equal result["first_name"], desired_customer.first_name
  end

  test "can find customer by last name parameter case insensitive match" do
    desired_customer = @customers[2]

    get "/api/v1/customers/find?last_name=#{desired_customer.last_name.upcase}"

    result = JSON.parse(response.body)

    assert_response :success
    assert_equal result["last_name"], desired_customer.last_name
  end

  test "can find customer by id parameter exact match" do
    desired_customer = @customers[2]

    get "/api/v1/customers/find?id=#{desired_customer.id}"

    result = JSON.parse(response.body)

    assert_response :success
    assert_equal result["id"], desired_customer.id
  end

  test "can find all customers by first_name case insensitive match" do
    [Customer.create(first_name: "Fred"), Customer.create(first_name: "Fred")]

    get "/api/v1/customers/find_all?first_name=FRed"

    result = JSON.parse(response.body)

    assert_response :success
    assert result.is_a?(Array)
    assert_equal result[0]["first_name"], "Fred"
    assert_equal result[1]["first_name"], "Fred"
  end

  test "can find all customers by last name exact match" do
    [Customer.create(last_name: "Johannesberg"), Customer.create(last_name: "Johannesberg")]

    get "/api/v1/customers/find_all?last_name=JoHaNnEsBeRg"

    result = JSON.parse(response.body)

    assert_response :success
    assert result.is_a?(Array)
    assert_equal result[0]["last_name"], "Johannesberg"
    assert_equal result[1]["last_name"], "Johannesberg"
  end
end
