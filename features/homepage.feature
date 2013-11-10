Feature: show search bar on the home page

  As the reader
  I want the search bar on the home page
  So that I can search books without a extra jump

Scenario: go to the home page

  Given I am on the homepage
  Then I should see "Search"
