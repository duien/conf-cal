class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :conference_session

  before_create :clear_timeslot

  scope :attended_by, lambda { |user| where( :user_id => user.id ) }
  scope :at_time, lambda { |time| joins( :conference_session ).where( :conference_sessions => { :start_time => time } ) }

  def clear_timeslot
    # delete_all asplodes with a .joins
    Attendance.at_time(self.timeslot).attended_by(self.user).each { |a| a.delete }
  end

  def timeslot
    self.conference_session.start_time
  end
end
