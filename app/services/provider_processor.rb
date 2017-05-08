class ProviderProcessor
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def add
    Provider.create(cleansed_attributes)
  end

  private

  def cleansed_attributes
    {
      name: data[:provider_name],
      street: data[:provider_street_address],
      city: data[:provider_city],
      state: data[:provider_state],
      zipcode: data[:provider_zip_code],
      referral: data[:hospital_referral_region_description],
      total_discharges: data[:_total_discharges_].to_i,
      average_covered_charges: data[:_average_covered_charges_],
      average_covered_charges_in_cents: average_covered_charges_in_cents,
      average_total_payments: data[:_average_total_payments_],
      average_medicare_payments: data[:average_medicare_payments],
      average_medicare_payments_in_cents: average_medicare_payments_in_cents
    }
  end

  def average_covered_charges_in_cents
    to_cents(data[:_average_covered_charges_])
  end

  def average_medicare_payments_in_cents
    to_cents(data[:average_medicare_payments])
  end

  def to_cents(amount)
    return unless amount
    (amount.gsub(/[^\d\.]/, '').to_f * 100).to_i
  end
end
