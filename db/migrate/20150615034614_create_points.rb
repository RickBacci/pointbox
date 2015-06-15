class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :amount, :default => 0
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
