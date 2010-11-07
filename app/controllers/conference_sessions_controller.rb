class ConferenceSessionsController < ApplicationController
  before_filter :login_required, :only => :index

  def index
    if params[:date] and params[:time]
      time = DateTime.parse("#{params[:date]} #{params[:time]}")
      @conference_sessions = ConferenceSession.all(
        :conditions => ["datetime(start_time) = datetime(?)", time],
        :include => :attendees,
        :order => :start_time)
      render 'date_time_index'
    else
      @conference_sessions = ConferenceSession.all(:include => :attendees, :order => :start_time)
      render
    end
  end

  def show
    @conference_session = ConferenceSession.find(params[:id])
  end
end
