class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.integer :user_id, :null => false
      t.string :title
      t.string :body
      t.timestamps
    end
  end

  def self.down
    drop_table :listings
  end
end
