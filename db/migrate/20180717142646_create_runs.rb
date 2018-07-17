class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :user_id
      t.integer :distance
      t.integer :time
      t.string :description
    end
  end
end
