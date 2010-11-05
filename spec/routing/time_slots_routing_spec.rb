require "spec_helper"

describe TimeSlotsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/time_slots" }.should route_to(:controller => "time_slots", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/time_slots/new" }.should route_to(:controller => "time_slots", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/time_slots/1" }.should route_to(:controller => "time_slots", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/time_slots/1/edit" }.should route_to(:controller => "time_slots", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/time_slots" }.should route_to(:controller => "time_slots", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/time_slots/1" }.should route_to(:controller => "time_slots", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/time_slots/1" }.should route_to(:controller => "time_slots", :action => "destroy", :id => "1")
    end

  end
end
