class UsersController < ApplicationController
  include Icalendar

  def show
    @user = User.find params[:id]

    respond_to do |format|
      format.html
      format.ics do

        @cal = Icalendar::Calendar.new
        @user.conference_sessions.each do |cs|
          @cal.event do
            dtstart     cs.start_time
            dtend       cs.end_time
            summary     cs.summary
            description cs.description
            location    cs.location
          end
        end
        @cal.publish

        render 'show.ics.haml', :layout => false 
      end
    end
  end
end
