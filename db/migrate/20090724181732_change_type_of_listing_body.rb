class ChangeTypeOfListingBody < ActiveRecord::Migration
  def self.up
    change_column :listings, :body, :text
  end

  def self.down
    change_column :listings , :body, :string
  end
end
