Feature: admin page
  As a admin of the system
  I want to have a page to look at all the records
  So that I can know the status from one place

Background: books and reader be added to the database

Given these books exist:
  |title     |author |total_num |remain_num |description |
  |Sunshine  |Bob    |3         |3          |Wangwang    |
  |Moonlight |Alice  |2         |2          |Miaomiao    |
  |My Life   |Alice  |1         |1          |Gogo        |

Given these users exist:
  |jobid            |name    |
  |2010010002       |Tom     |
  |2010000000       |Tim     |

And these readers exist:
  |name |email     |       
  |Tom  |hi@g.com  |       
  |Tim  |tim@r.com |      

And these borrow relations exist:
  |book_title |reader_name|
  |Moonlight  |Tom        |
  |My Life    |Tim        |

And I login as admin

Scenario: admin login
  Given I am on the admin page
  Then I should see "The borrowing status"
  And I should see "Moonlight"
  And I should not see "Sunshine"

Scenario: admin view books
  When I am on the admin page
  And I follow "Transfer"
  Then I should see "Sunshine"

Scenario: admin turns pages
  Given many book in database
  Given I am on the admin page
  When I follow "Transfer"
  And I fill in "search_keywords" with "Bo"
  And I press "search_button"
  Then I should see "Book1"
  And I should not see "Sunshine"
  Then I follow "next page"
  Then I should see "Book40"
