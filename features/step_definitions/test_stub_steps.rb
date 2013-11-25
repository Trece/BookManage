Given /I am the super user/ do
  ReadersController.any_instance.stub(:auth_admin).and_return(true)
end
