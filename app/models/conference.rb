class Conference < ActiveRecord::Base
  CURRENT = 2 # TODO This is a horrible hack to only show one conference at a time

  has_many :conference_sessions
end
