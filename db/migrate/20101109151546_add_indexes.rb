class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :attendances, :conference_session_id
    add_index :attendances, :user_id
    add_index :conference_sessions, [:start_time, :location]
    add_index :users, :twitter_id
    add_index :friendships, :user_id
  end

  def self.down
    remove_index :attendances, :conference_session_id
    remove_index :attendances, :user_id
    remove_index :conference_sessions, [:start_time, :location]
    remove_index :users, :twitter_id
    remove_index :friendships, :user_id
  end
end
