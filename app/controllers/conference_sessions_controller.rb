class ConferenceSessionsController < ApplicationController

  respond_to :js, :json, :except => [ :for ]
  respond_to :html

  def index
    if params[:date] and params[:time]
      time = DateTime.parse("#{params[:date]} #{params[:time]}")
      if current_user
        @next_timeslot = ConferenceSession.next_unscheduled_timeslot( current_user, time )
        @prev_timeslot = ConferenceSession.prev_unscheduled_timeslot( current_user, time )
      end

      respond_with(@conference_sessions = ConferenceSession.all( :conditions => { :start_time => time }, :include => :attendees )) do |format|
        format.html { render 'date_time_index' }
        format.mobile { render 'date_time_index' }
      end
    else
      respond_with(@conference_sessions = ConferenceSession.all(:include => :attendees))
    end
  end

  def show
    respond_with(@conference_session = ConferenceSession.find(params[:id]))
  end

  # Crappy non-RESTful method to return a div for a particular timeslot.  :-(
  #
  def for
    timeslot = Time.parse(params[:timeslot])
    timeslot = (timeslot + timeslot.gmtoff).utc  # Holy hell this is nasty.  Why doesn't Time.utc work like Time.parse?
    render :partial => 'aggregate', 
           :locals => { 
              :conference_sessions => ConferenceSession.all( :conditions => { :start_time => timeslot } ) 
           }
  end
end
