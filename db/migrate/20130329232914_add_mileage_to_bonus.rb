class AddMileageToBonus < ActiveRecord::Migration
  def change
    add_column :bonuses, :mileage, :decimal
  end
end
