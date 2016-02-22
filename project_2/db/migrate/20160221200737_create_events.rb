class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :game
      t.integer :number_places

      t.timestamps null: false
    end
  end
end
