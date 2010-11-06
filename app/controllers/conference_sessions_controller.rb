class ConferenceSessionsController < ApplicationController
  before_filter :login_required, :only => :index

  def index
    sessions= if params[:date] and params[:time]
      time = DateTime.parse("#{params[:date]} #{params[:time]}")
      ConferenceSession.all( #:conditions => { :start_time => time } )
        :conditions => ["datetime(start_time) = datetime(?)", time],
        :include => :attendees )
    else
      ConferenceSession.all(:include => :attendees)
    end
    sessions = sessions.group_by { |p| p.start_time.strftime('%A') }
    @conference_sessions = sessions.inject({}) do |result, (day, session_list)|
      result.update(day => session_list.group_by(&:start_time))
    end
  end

  def show
    @conference_session = ConferenceSession.find(params[:id])
  end
end
