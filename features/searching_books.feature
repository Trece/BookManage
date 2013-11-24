# -*- coding: utf-8 -*-
Feature: searching books
  
  As a user of the system
  I want to search books in the library
  So that I can find the book I want quickly

Background: books should be added to the database

  Given these books exist:
  |title     |author |
  |Sunshine  |Bob    |
  |Moonlight |Alice  |
  |My Life   |Alice  |

  
Scenario: search books by title
  Given I am on the book index page
  When I select "标题" from "search_type"
  And I fill in "search_keywords" with "Moonlight"
  And I press "search_button"
  Then I should be on the book index page
  Then I should see book "Moonlight"
  And I should not see book "Sunshine"
  And I should not see book "My life"

Scenario: search books by author
  Given I am on the book index page
  When I select "作者" from "search_type"
  And I fill in "search_keywords" with "Bob"
  And I press "search_button"
  Then I should be on the book index page
  Then I should not see book "Moonlight"
  And I should see book "Sunshine"
  And I should not see book "My life"
