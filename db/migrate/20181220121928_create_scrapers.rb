class CreateScrapers < ActiveRecord::Migration[5.2]
  def change
    create_table :scrapers do |t|
      t.string :address
      t.string :price
      t.string :home_details
      t.datetime :date

      t.timestamps
    end
  end
end
