require 'spec_helper'

describe "time_slots/new.html.haml" do
  before(:each) do
    assign(:time_slot, stub_model(TimeSlot).as_new_record)
  end

  it "renders new time_slot form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => time_slots_path, :method => "post" do
    end
  end
end
