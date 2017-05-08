class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :referral
      t.integer :total_discharges
      t.string :average_covered_charges
      t.integer :average_covered_charges_in_cents
      t.string :average_total_payments
      t.string :average_medicare_payments
      t.integer :average_medicare_payments_in_cents

      t.timestamps null: false
    end
  end
end
