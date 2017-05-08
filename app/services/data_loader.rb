require 'csv'

class DataLoader
  attr_reader :file, :csv

  def initialize(file)
    @file = file
    @csv = CSV.open(file, headers: true, header_converters: :symbol)
  end

  def insert_providers
    csv.each do |row|
      ProviderProcessor.new(row).add
    end
  end
end
