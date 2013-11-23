require 'spec_helper'

describe "readers/show" do
  before(:each) do
    @reader = assign(:reader, stub_model(Reader))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
