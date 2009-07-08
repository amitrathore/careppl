class CreateAppliedListings < ActiveRecord::Migration
  def self.up
    create_table :applied_listings do |t|
      t.integer :listing_id, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :applied_listings
  end
end
