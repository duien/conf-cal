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
      sessions = ConferenceSession.all(:include => :attendees, :order => :start_time)
      sessions = sessions.group_by { |p| p.start_time.strftime('%A') }
      @conference_sessions = sessions.inject({}) do |result, (day, session_list)|
        result.update(day => session_list.group_by(&:start_time))
      end
      render
    end
  end

  def show
    @conference_session = ConferenceSession.find(params[:id])
  end
end
