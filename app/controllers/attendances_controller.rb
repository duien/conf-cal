class AttendancesController < ApplicationController
  before_filter :login_required

  def create
    @attendance = Attendance.new(params[:attendance])

    respond_to do |format|
      if @attendance.save
        format.json { render :json => @attendance, :status => :created, :location => @attendance }
      else
        format.json  { render :json => @attendance.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end
end
