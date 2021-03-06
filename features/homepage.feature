Feature: show search bar on the home page

  As the reader
  I want the search bar on the home page
  So that I can search books without a extra jump

Background: readers should be in the database

  Given these users exist:
  |jobid            |name    |
  |2010010002       |Tom     |
  |2010000000       |Tim     |

  And these readers exist:
  |name |email     |       
  |Tom  |hi@g.com  |       
  |Tim  |tim@r.com |      
  
Scenario: go to the home page

  Given I am on the homepage
  Then I should see "Search" button
  
Scenario: if I am a guest, I can login
  Given I am on the home page
  Then I should see "login"
  
Scenario: if I have already logined, I can logout
  Given I login as normal user with jobid "2010010002", name "Tom", email "hi@g.com"
  Then I should see "logout"
  And I follow "logout"
  Then I should see "login"

