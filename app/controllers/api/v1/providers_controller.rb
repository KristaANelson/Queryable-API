class Api::V1::ProvidersController < ApplicationController
  def index
    @providers = Provider.where(nil)
    apply_filters
    serialize_providers
    render json: @providers
  end

  private

  def apply_filters
    filtering_params(params).each do |key, value|
      value = value.to_i unless key == "state"
      @providers = @providers.public_send(key, value) if value.present?
    end
  end

  def serialize_providers
    @providers = @providers.map{ |p| Api::V1::ProviderSerializer.new(p) }.to_json
  end

  def filtering_params(params)
    params.slice(:min_discharges,
                 :max_discharges,
                 :min_average_covered_charges,
                 :max_average_covered_charges,
                 :min_average_medicare_payments,
                 :max_average_medicare_payments,
                 :state)
  end
end
