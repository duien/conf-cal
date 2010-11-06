class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :conference_session
end
