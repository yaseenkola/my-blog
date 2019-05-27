class AddUserIdToAmol361s < ActiveRecord::Migration[5.1]
  def change
    add_column :amol361s, :user_id, :integer
  end
end
