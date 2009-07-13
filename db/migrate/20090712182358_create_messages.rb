class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id, :null => false
      t.integer :recepient
      t.string :subject
      t.text :body
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
