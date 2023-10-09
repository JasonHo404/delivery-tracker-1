class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.integer :user_id
      t.string :description
      t.date :expected
      t.string :detail
      t.boolean :received

      t.timestamps
    end
  end
end
