class CreateCheckin < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :merchant_id
      t.integer :person_id

      t.timestamps
    end
  end
end
