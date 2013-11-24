Feature: operating books in database
  
  As a admin of the system
  I want to keep track on books' borrowing and returning
  So that I can know the current state of books

Background: books and readers should be added to the database

  Given these books exist:
  |title     |author |total_num |remain_num |description |
  |Sunshine  |Bob    |3         |3          |Wangwang    |
  |Moonlight |Alice  |2         |2          |Miaomiao    |
  |My Life   |Alice  |1         |1          |Gogo        |

  And these readers exist:
  |name |email     |
  |Tom  |hi@g.com  |
  |Tim  |tim@r.com |

  And these borrow relations exist:
  |book_title |reader_name|
  |Moonlight  |Tom        |
  |My Life    |Tim        |

  Given I logined as admin
  When I am on the home page
  And I follow "view_book"
  
Scenario: someone borrows a book with enough left
  Then I go to the details page for "Moonlight"
  When I fill in "borrow_reader" with "Tim"
  And I press "borrow_button"
  Then I should see "0/2"
  And I should see "Tim"
  And I should see "Borrowed successfully"

Scenario: someone borrows a book without enough left
  Given I am on the details page for "My Life"
  When I fill in "borrow_reader" with "Tom"
  And I press "borrow_button"
  Then I should see "0/1"
  And I should not see "Tom"
  And I should see "No more book left"

Scenario: someone returns a book
  Given I am on the details page for "Moonlight"
  When I select "Tom" from "return_reader"
  And I press "return_button"
  Then I should see "2/2"
  And I should see "Return successfully"


