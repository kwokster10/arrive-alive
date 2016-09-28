class DropInEmergencyAndAddUserIdFromFloatPlan < ActiveRecord::Migration
  def change
    remove_column :float_plans, :in_emergency
    add_reference :float_plans, :user, index: true
  end
end
