require 'spec_helper'

describe "readers/edit" do
  before(:each) do
    @reader = assign(:reader, stub_model(Reader))
  end

  it "renders the edit reader form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reader_path(@reader), "post" do
    end
  end
end
