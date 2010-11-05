require 'spec_helper'

describe "time_slots/edit.html.haml" do
  before(:each) do
    @time_slot = assign(:time_slot, stub_model(TimeSlot,
      :new_record? => false
    ))
  end

  it "renders the edit time_slot form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => time_slot_path(@time_slot), :method => "post" do
    end
  end
end
