class Conference < ActiveRecord::Base
  has_many :conference_sessions
end
