require 'spec_helper'

describe "readers/index" do
  before(:each) do
    assign(:readers, [
      stub_model(Reader),
      stub_model(Reader)
    ])
  end

  it "renders a list of readers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
