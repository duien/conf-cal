class ConferenceSession < ActiveRecord::Base
  validates_uniqueness_of :uid
  has_many :attendances
  has_many :attendees, :through => :attendances, :source => :user, :class_name => 'User'

  belongs_to :conference
  validates_presence_of :conference

  default_scope order(:start_time, :location).where(:conference_id => Conference::CURRENT)

  scope :later_than,      lambda { |time| where( 'start_time > ?', time ) }
  scope :earlier_than,    lambda { |time| where( 'start_time < ?', time ) }

  def self.next_unscheduled_timeslot (user, time)
    sql = "SELECT min(start_time) FROM conference_sessions cs WHERE start_time > '#{time.to_s(:db)}' AND cs.conference_id = #{Conference::CURRENT} AND NOT EXISTS (SELECT 'x' FROM attendances a, conference_sessions cs2 WHERE a.user_id = #{user.id} AND a.conference_session_id = cs2.id AND cs.start_time = cs2.start_time)" 
    string = ActiveRecord::Base.connection.select_rows(sql).first.first
    string.nil? ? nil : Time.parse(string)
  end

  def self.prev_unscheduled_timeslot (user, time)
    sql = "SELECT max(start_time) FROM conference_sessions cs WHERE start_time < '#{time.to_s(:db)}' AND cs.conference_id = #{Conference::CURRENT} AND NOT EXISTS (SELECT 'x' FROM attendances a, conference_sessions cs2 WHERE a.user_id = #{user.id} AND a.conference_session_id = cs2.id AND cs.start_time = cs2.start_time)" 
    string = ActiveRecord::Base.connection.select_rows(sql).first.first
    string.nil? ? nil : Time.parse(string)
  end
end
