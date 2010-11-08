class UsersController < ApplicationController
  include Icalendar

  def show
    @user = User.find params[:id]

    respond_to do |format|
      format.html
      format.ics { render 'show.ics.haml', :layout => false }
    end
  end
end
