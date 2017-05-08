class Provider < ActiveRecord::Base
  validates_presence_of [:state,
                         :total_discharges,
                         :average_covered_charges_in_cents,
                         :average_medicare_payments_in_cents]

  scope :state, -> (state) { where state: state }
  scope :min_discharges, -> (min) { where(["total_discharges >= ?", min]) }
  scope :max_discharges, -> (max) { where(["total_discharges <= ?", max]) }
  scope :min_average_covered_charges, (lambda do |min|
    where(["average_covered_charges_in_cents >= ?", min*100])
  end)
  scope :max_average_covered_charges, (lambda do |max|
    where(["average_covered_charges_in_cents <= ?", max*100])
  end)
  scope :min_average_medicare_payments, (lambda do |min|
    where(["average_medicare_payments_in_cents >= ?", min*100])
  end)
  scope :max_average_medicare_payments, (lambda do |max|
    where(["average_medicare_payments_in_cents <= ?", max*100])
  end)
end
