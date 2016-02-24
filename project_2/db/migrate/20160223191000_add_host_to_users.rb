class AddHostToUsers < ActiveRecord::Migration
  def change
    add_column :users, :true_or_false, :boolean
  end
end
