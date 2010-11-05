require 'spec_helper'

describe "time_slots/show.html.haml" do
  before(:each) do
    @time_slot = assign(:time_slot, stub_model(TimeSlot))
  end

  it "renders attributes in <p>" do
    render
  end
end
