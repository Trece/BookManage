Feature: manage personal profile

    As a reader of the system
    I want to be able to manage my profile
    So that I can be notify by the library to return books and notify my reservation

Background: persons should be added to database
  Given these users exist:
  |jobid            |name    |
  |2010010001       |Tom     |
  |2010000000       |Tim     |

  Given these readers exist:
  |name  |email      |phone     |
  |Tom   |hi@g.com   |12345678  |
  |Tim   |           |          |

  Given I am on the home page
  And I follow "login"

Scenario: admin can see all readers
  # should login as admin... hack
  Given I am on the details page for reader "Tom"
  And I follow "back"
  Then I should see "Tom"
  Then I should see "Tim"

Scenario: someone updated his name
  Given I am on the details page for reader "Tom"
  Then I should see "Tom"
  And I follow "edit"
  Then I fill in "reader_name" with "adobe"
  And I press "save"
  Then I should see "adobe"

Scenario: someone updated his telephone number
  Given I am on the details page for reader "Tom"
  Then I should see "Tom"
  And I follow "edit"
  Then I fill in "reader_email" with "adobe@stupid.com"
  And I press "save"
  Then I should see "adobe@stupid.com"

Scenario: someone updated his email address
  Given I am on the details page for reader "Tom"
  Then I should see "Tom"
  And I follow "edit"
  Then I fill in "reader_phone" with "2333333"
  And I press "save"
  Then I should see "2333333"
