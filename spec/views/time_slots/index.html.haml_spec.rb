require 'spec_helper'

describe "time_slots/index.html.haml" do
  before(:each) do
    assign(:time_slots, [
      stub_model(TimeSlot),
      stub_model(TimeSlot)
    ])
  end

  it "renders a list of time_slots" do
    render
  end
end
