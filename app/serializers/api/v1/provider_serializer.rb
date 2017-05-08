class Api::V1::ProviderSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data["Provider Name"] = object.name
		data["Provider Street Address"] = object.street
		data["Provider City"] = object.city
		data["Provider State"] = object.state
		data["Provider Zip Code"] = object.zipcode
		data["Hospital Referral Region Description"] = object.referral
		data["Total Discharges"] = object.total_discharges
		data["Average Covered Charges"] = object.average_covered_charges
		data["Average Total Payments"] = object.average_total_payments
		data["Average Medicare Payments"] = object.average_medicare_payments
		data
  end
end
