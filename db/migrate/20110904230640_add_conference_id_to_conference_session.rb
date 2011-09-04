class Conference < ActiveRecord::Base; end
class ConferenceSession < ActiveRecord::Base
  belongs_to :conference
end

class AddConferenceIdToConferenceSession < ActiveRecord::Migration
  def self.up
    add_column :conference_sessions, :conference_id, :integer

    rubyconf_2010 = Conference.find_by_name('RubyConf 2010')
    ConferenceSession.all.each{ |c| c.update_attribute(:conference, rubyconf_2010) }

    change_column :conference_sessions, :conference_id, :integer, :null => false
  end

  def self.down
    remove_column :conference_sessions, :conference_id
  end
end
