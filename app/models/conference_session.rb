class ConferenceSession < ActiveRecord::Base
  validates_uniqueness_of :uid
  has_many :attendances
  has_many :attendees, :through => :attendances, :source => :user, :class_name => 'User'
end
