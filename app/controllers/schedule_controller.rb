class ScheduleController < ApplicationController
  before_filter :login_required

  def index
    @all_sessions = ConferenceSession.all(:include => :attendees )
  end
end
