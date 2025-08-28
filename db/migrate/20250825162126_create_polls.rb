class CreatePolls < ActiveRecord::Migration[8.0]
  def change
    create_table :polls do |t|
      t.string :question, null: false
      t.string :poll_type, null: false
      t.string :status, default: 'open', null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :polls, :status
  end
end
