class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.text :name
    end
  end
end
