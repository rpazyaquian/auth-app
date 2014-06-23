class CreateStockSearches < ActiveRecord::Migration
  def change
    create_table :stock_searches do |t|
      t.string :symbol
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
