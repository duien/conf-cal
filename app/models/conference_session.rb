class ConferenceSession < ActiveRecord::Base
  validates_uniqueness_of :uid
  has_many :attendances
  has_many :attendees, :through => :attendances, :source => :user, :class_name => 'User'

  default_scope order(:start_time, :location)

  scope :later_than,      lambda { |time| where( 'start_time > ?', time ) }
  scope :earlier_than,    lambda { |time| where( 'start_time < ?', time ) }

  def self.next_unscheduled_timeslot (user, time)
    unattended_by = "not exists (SELECT 'x' from attendances where conference_session_id = conference_sessions.id and user_id = ?)"
    sess = later_than(time).where(unattended_by, user.id ).first
    sess.nil? ? nil : sess.start_time
  end

  def self.prev_unscheduled_timeslot (user, time)
    unattended_by = "not exists (SELECT 'x' from attendances where conference_session_id = conference_sessions.id and user_id = ?)"
    sess = earlier_than(time).where(unattended_by, user.id ).last
    sess.nil? ? nil : sess.start_time
  end
end
