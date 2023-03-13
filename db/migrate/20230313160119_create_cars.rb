class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.references :user, null: false, foreign_key: true
      t.float :price
      t.integer :year

      t.timestamps
    end
  end
end
