class AddLastUpdatedFriendsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_updated_friends, :time
  end

  def self.down
    remove_column :users, :last_updated_friends
  end
end
