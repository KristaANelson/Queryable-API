require "test_helper"

class Api::V1::ProvidersControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 4, providers.count
    assert_equal "GADSDEN MEDICAL CENTER", first_provider["Provider Name"]
    assert_equal "1007 GOODYEAR AVE", first_provider["Provider Street Address"]
    assert_equal "GADSDEN", first_provider["Provider City"]
    assert_equal "AL", first_provider["Provider State"]
    assert_equal "35903", first_provider["Provider Zip Code"]
    assert_equal "AL- B", first_provider["Hospital Referral Region Description"]
    assert_equal 340, first_provider["Total Discharges"]
    assert_equal "$233.38", first_provider["Average Covered Charges"]
    assert_equal "$5,541.05", first_provider["Average Total Payments"]
    assert_equal "$4,386.94", first_provider["Average Medicare Payments"]
    assert_nil first_provider["id"]
  end

  test "#index with state query" do
    get :index, state: "AL", format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal "AL", first_provider["Provider State"]
  end

  test "#index with min_discharges query" do
    get :index, min_discharges: 999, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal 999, first_provider["Total Discharges"]
  end

  test "#index with max_discharges query" do
    get :index, max_discharges: 340, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal 340, first_provider["Total Discharges"]
  end

  test "#index with min_average_covered_charges query" do
    get :index, min_average_covered_charges: 99233, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal "$99,233.00", first_provider["Average Covered Charges"]
  end

  test "#index with max_average_covered_charges query" do
    get :index, max_average_covered_charges: 234, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal "$233.38", first_provider["Average Covered Charges"]
  end

  test "#index with min_average_medicare_payments query" do
    get :index, min_average_medicare_payments: 800386, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal "$800,386.99", first_provider["Average Medicare Payments"]
  end

  test "#index with max_average_medicare_payments query" do
    get :index, max_average_medicare_payments: 4387, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal "$4,386.94", first_provider["Average Medicare Payments"]
  end

  test "#index with all queries" do
    queries = {
      min_discharges: 340,
      max_discharges: 340,
      min_average_covered_charges: 233,
      max_average_covered_charges: 234,
      min_average_medicare_payments: 4386,
      max_average_medicare_payments: 4387,
      state: "AL"
    }
    get :index, max_average_medicare_payments: 4387, format: :json

    providers = JSON.parse(response.body)
    first_provider = providers.first

    assert_response :success
    assert_equal 1, providers.count
    assert_equal "GADSDEN MEDICAL CENTER", first_provider["Provider Name"]
  end
end
