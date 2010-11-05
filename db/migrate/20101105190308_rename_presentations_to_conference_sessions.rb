class RenamePresentationsToConferenceSessions < ActiveRecord::Migration
  def self.up
    rename_table :presentations, :conference_sessions
  end

  def self.down
    rename_table :conference_sessions, :presentations
  end
end
