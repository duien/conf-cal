class ConferenceSessionsController < ApplicationController

  def index
    if params[:date] and params[:time]
      time = DateTime.parse("#{params[:date]} #{params[:time]}")
      @conference_sessions = ConferenceSession.all( :conditions => { :start_time => time }, :include => :attendees )
      render 'date_time_index'
    else
      @conference_sessions = ConferenceSession.all(:include => :attendees)
      render
    end
  end

  def show
    @conference_session = ConferenceSession.find(params[:id])
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
