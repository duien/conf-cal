require 'spec_helper'

describe TimeSlotsController do

  def mock_time_slot(stubs={})
    (@mock_time_slot ||= mock_model(TimeSlot).as_null_object).tap do |time_slot|
      time_slot.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all time_slots as @time_slots" do
      TimeSlot.stub(:all) { [mock_time_slot] }
      get :index
      assigns(:time_slots).should eq([mock_time_slot])
    end
  end

  describe "GET show" do
    it "assigns the requested time_slot as @time_slot" do
      TimeSlot.stub(:find).with("37") { mock_time_slot }
      get :show, :id => "37"
      assigns(:time_slot).should be(mock_time_slot)
    end
  end

  describe "GET new" do
    it "assigns a new time_slot as @time_slot" do
      TimeSlot.stub(:new) { mock_time_slot }
      get :new
      assigns(:time_slot).should be(mock_time_slot)
    end
  end

  describe "GET edit" do
    it "assigns the requested time_slot as @time_slot" do
      TimeSlot.stub(:find).with("37") { mock_time_slot }
      get :edit, :id => "37"
      assigns(:time_slot).should be(mock_time_slot)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created time_slot as @time_slot" do
        TimeSlot.stub(:new).with({'these' => 'params'}) { mock_time_slot(:save => true) }
        post :create, :time_slot => {'these' => 'params'}
        assigns(:time_slot).should be(mock_time_slot)
      end

      it "redirects to the created time_slot" do
        TimeSlot.stub(:new) { mock_time_slot(:save => true) }
        post :create, :time_slot => {}
        response.should redirect_to(time_slot_url(mock_time_slot))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved time_slot as @time_slot" do
        TimeSlot.stub(:new).with({'these' => 'params'}) { mock_time_slot(:save => false) }
        post :create, :time_slot => {'these' => 'params'}
        assigns(:time_slot).should be(mock_time_slot)
      end

      it "re-renders the 'new' template" do
        TimeSlot.stub(:new) { mock_time_slot(:save => false) }
        post :create, :time_slot => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested time_slot" do
        TimeSlot.should_receive(:find).with("37") { mock_time_slot }
        mock_time_slot.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :time_slot => {'these' => 'params'}
      end

      it "assigns the requested time_slot as @time_slot" do
        TimeSlot.stub(:find) { mock_time_slot(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:time_slot).should be(mock_time_slot)
      end

      it "redirects to the time_slot" do
        TimeSlot.stub(:find) { mock_time_slot(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(time_slot_url(mock_time_slot))
      end
    end

    describe "with invalid params" do
      it "assigns the time_slot as @time_slot" do
        TimeSlot.stub(:find) { mock_time_slot(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:time_slot).should be(mock_time_slot)
      end

      it "re-renders the 'edit' template" do
        TimeSlot.stub(:find) { mock_time_slot(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested time_slot" do
      TimeSlot.should_receive(:find).with("37") { mock_time_slot }
      mock_time_slot.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the time_slots list" do
      TimeSlot.stub(:find) { mock_time_slot }
      delete :destroy, :id => "1"
      response.should redirect_to(time_slots_url)
    end
  end

end
