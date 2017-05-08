require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  test 'valid provider' do
    valid_attributes = { state: "CA",
                         total_discharges: 43,
                         average_covered_charges_in_cents: 143200,
                         average_medicare_payments_in_cents: 232100 }

    provider = Provider.new(valid_attributes)

    assert provider.valid?
  end

  test 'invalid without state' do
    bad_attributes = { total_discharges: 43,
                       average_covered_charges_in_cents: 143200,
                       average_medicare_payments_in_cents: 232100 }

    provider = Provider.new(bad_attributes)

    refute provider.valid?
  end

  test 'invalid without total_discharges' do
    bad_attributes = { state: "CA",
                       average_covered_charges_in_cents: 143200,
                       average_medicare_payments_in_cents: 232100 }

    provider = Provider.new(bad_attributes)

    refute provider.valid?
  end

  test 'invalid without average_covered_charges_in_cents' do
    bad_attributes = { state: "CA",
                       total_discharges: 43,
                       average_medicare_payments_in_cents: 232100 }

    provider = Provider.new(bad_attributes)

    refute provider.valid?
  end

  test 'invalid without average_medicare_payments_in_cent' do
    bad_attributes = { state: "CA",
                       total_discharges: 43,
                       average_covered_charges_in_cents: 143200 }

    provider = Provider.new(bad_attributes)

    refute provider.valid?
  end

  test '#state' do
    assert_includes Provider.state("AL"), providers(:one)
    refute_includes Provider.state("AL"), providers(:two)
    refute_includes Provider.state("AL"), providers(:three)
    refute_includes Provider.state("AL"), providers(:four)
  end

  test '#min_discharges' do
    refute_includes Provider.min_discharges(400), providers(:one)
    assert_includes Provider.min_discharges(400), providers(:two)
    assert_includes Provider.min_discharges(400), providers(:three)
    assert_includes Provider.min_discharges(400), providers(:four)
  end

  test '#max_discharges' do
    assert_includes Provider.max_discharges(400), providers(:one)
    refute_includes Provider.max_discharges(400), providers(:two)
    refute_includes Provider.max_discharges(400), providers(:three)
    refute_includes Provider.max_discharges(400), providers(:four)
  end

  test '#min_average_covered_charges' do
    refute_includes Provider.min_average_covered_charges(5233), providers(:one)
    assert_includes Provider.min_average_covered_charges(5233), providers(:two)
    assert_includes Provider.min_average_covered_charges(5233), providers(:three)
    assert_includes Provider.min_average_covered_charges(5233), providers(:four)
  end

  test '#max_average_covered_charges' do
    assert_includes Provider.max_average_covered_charges(239), providers(:one)
    refute_includes Provider.max_average_covered_charges(239), providers(:two)
    refute_includes Provider.max_average_covered_charges(239), providers(:three)
    refute_includes Provider.max_average_covered_charges(239), providers(:four)
  end

  test '#min_average_medicare_payments' do
    refute_includes Provider.min_average_medicare_payments(4389), providers(:one)
    assert_includes Provider.min_average_medicare_payments(4389), providers(:two)
    assert_includes Provider.min_average_medicare_payments(4389), providers(:three)
    assert_includes Provider.min_average_medicare_payments(4389), providers(:four)
  end

  test '#max_average_medicare_payments' do
    assert_includes Provider.max_average_medicare_payments(23339), providers(:one)
    refute_includes Provider.max_average_medicare_payments(23339), providers(:two)
    refute_includes Provider.max_average_medicare_payments(23339), providers(:three)
    refute_includes Provider.max_average_medicare_payments(23339), providers(:four)
  end
end
