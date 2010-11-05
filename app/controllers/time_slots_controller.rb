class TimeSlotsController < ApplicationController
  # GET /time_slots
  # GET /time_slots.xml
  def index
    @time_slots = TimeSlot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @time_slots }
    end
  end

  # GET /time_slots/1
  # GET /time_slots/1.xml
  def show
    @time_slot = TimeSlot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @time_slot }
    end
  end

  # GET /time_slots/new
  # GET /time_slots/new.xml
  def new
    @time_slot = TimeSlot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @time_slot }
    end
  end

  # GET /time_slots/1/edit
  def edit
    @time_slot = TimeSlot.find(params[:id])
  end

  # POST /time_slots
  # POST /time_slots.xml
  def create
    @time_slot = TimeSlot.new(params[:time_slot])

    respond_to do |format|
      if @time_slot.save
        format.html { redirect_to(@time_slot, :notice => 'Time slot was successfully created.') }
        format.xml  { render :xml => @time_slot, :status => :created, :location => @time_slot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @time_slot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /time_slots/1
  # PUT /time_slots/1.xml
  def update
    @time_slot = TimeSlot.find(params[:id])

    respond_to do |format|
      if @time_slot.update_attributes(params[:time_slot])
        format.html { redirect_to(@time_slot, :notice => 'Time slot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @time_slot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_slots/1
  # DELETE /time_slots/1.xml
  def destroy
    @time_slot = TimeSlot.find(params[:id])
    @time_slot.destroy

    respond_to do |format|
      format.html { redirect_to(time_slots_url) }
      format.xml  { head :ok }
    end
  end
end
