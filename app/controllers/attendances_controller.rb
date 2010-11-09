class AttendancesController < ApplicationController
  before_filter :login_required

  def create
    @attendance = Attendance.new(params[:attendance])

    respond_to do |format|
      if @attendance.save
        format.json { render :json => @attendance, :status => :created, :location => @attendance }
        format.js { render :replace_section }
      else
        format.json  { render :json => @attendance.errors, :status => :unprocessable_entity }
        format.js { head :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy

    respond_to do |format|
      format.json  { head :ok }
      format.js { render :replace_section }
    end
  end
end
