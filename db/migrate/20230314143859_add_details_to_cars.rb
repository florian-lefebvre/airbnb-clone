class AddDetailsToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :kilometers, :string
    add_column :cars, :model, :string
    add_column :cars, :type, :string
    add_column :cars, :color, :string
    add_column :cars, :seats, :integer
  end
end
