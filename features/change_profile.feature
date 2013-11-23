Feature: manage personal profile

    As a reader of the system
    I want to be able to manage my profile
    So that I can be notify by the library to return books and notify my reservation

Background: persons should be added to database

  Given these readers exist:
  |name  |email      |phone     |
  |Tom   |hi@g.com   |12345678  |
  |Tim   |           |          |
  |Tenut |tenut@a.com|          |

Scenario: someone added his email address
  Given I am on the details page for personal
