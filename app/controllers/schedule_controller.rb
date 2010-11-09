class ScheduleController < ApplicationController
  before_filter :login_required

  def index
    @all_sessions = ConferenceSession.all(:include => :attendees )

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
