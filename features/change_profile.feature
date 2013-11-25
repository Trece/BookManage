Feature: manage personal profile

    As a reader of the system
    I want to be able to manage my profile
    So that I can be notify by the library to return books and notify my reservation

Background: persons should be added to database
  Given these users exist:
  |jobid            |name    |
  |2010010002       |Tom     |
  |2010000000       |Tim     |

  Given these readers exist:
  |name  |email      |phone     |
  |Tom   |hi@g.com   |12345678  |
  |Tim   |d@k.com    |23332     |


Scenario: admin can see all readers
  Given I login as admin
  And I am on the readers page
  Then I should see "Tom"
  Then I should see "Tim"

Scenario: non-admin try to see all readers
  Given I login as normal user with jobid "2010010002", name "Tom", email "hi@g.com"
  And I am on the readers page
  Then I should be on the home page
  And I should see "Permission denied"

Scenario: someone updated his name
  Given I login as normal user with jobid "2010010002", name "Tom", email "hi@g.com"
  And I am on the details page for reader "Tom"
  Then I should see "Tom"
  And I follow "edit"
  Then I fill in "reader_name" with "adobe"
  And I press "save"
  Then I should be on the details page for reader "adobe"
  And I should see "adobe"


Scenario: someone updated his telephone number
  Given I login as normal user with jobid "2010010002", name "Tom", email "hi@g.com"
  And I am on the details page for reader "Tom"
  Then I should see "Tom"
  And I follow "edit"
  Then I fill in "reader_email" with "adobe@stupid.com"
  And I press "save"
  Then I should see "adobe@stupid.com"

Scenario: someone updated his email address
  Given I login as normal user with jobid "2010010002", name "Tom", email "hi@g.com"
  And I am on the details page for reader "Tom"
  Then I should see "Tom"
  And I follow "edit"
  Then I fill in "reader_phone" with "2333333"
  And I press "save"
  Then I should see "2333333"

Scenario: someone try to see other's info
  Given I login as normal user with jobid "201010003", name "Joss", email "Kk@kk.com"
  And I am on the details page for reader "Tom"
  Then I should be on the home page
  And I should see "Permission denied"