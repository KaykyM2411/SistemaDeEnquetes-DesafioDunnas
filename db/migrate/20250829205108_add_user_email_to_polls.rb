class AddUserEmailToPolls < ActiveRecord::Migration[8.0]
  def change
    add_column :polls, :user_email, :string
  end
end
