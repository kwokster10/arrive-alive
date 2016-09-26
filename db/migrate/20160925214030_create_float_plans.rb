class CreateFloatPlans < ActiveRecord::Migration
  def change
    create_table :float_plans do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :arrival_time
      t.string :start_location
      t.string :arrival_location
      t.integer :boat_number
      t.string :email
      t.string :phone_number
      t.json :participants
      t.string :direction_of_sail
      t.string :current
      t.boolean :had_vhf_radio
      t.boolean :had_three_flares
      t.boolean :had_throw_rope
      t.boolean :had_checked_weather
      t.boolean :in_emergency, default: false
      t.integer :state, default: 0, index: true
      t.text :notes

      t.timestamps null: false
    end
  end
end
