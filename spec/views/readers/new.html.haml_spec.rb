require 'spec_helper'

describe "readers/new" do
  before(:each) do
    assign(:reader, stub_model(Reader).as_new_record)
  end

  it "renders new reader form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", readers_path, "post" do
    end
  end
end
