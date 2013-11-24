require 'spec_helper'

describe User do
  it "should response to admin judgement" do
    u = User.create(jobid: "123455", name: "Tom")
    u.is_admin?.should == false
  end
  it "should return have these utility methods" do
    User.appid.should_not == nil
    User.ticket_url.should_not == nil
    User.ip.should_not == nil
  end
end
