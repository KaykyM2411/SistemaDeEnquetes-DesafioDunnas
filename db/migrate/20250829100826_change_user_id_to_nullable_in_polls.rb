class ChangeUserIdToNullableInPolls < ActiveRecord::Migration[8.0]
  def change
    change_column_null :polls, :user_id, true
  end
end
