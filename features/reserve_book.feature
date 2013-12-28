# -*- coding : utf-8 -*-
Feature: reserving books

  As a reader
  I want to reserving books
  So that when no book available I can reserve it and get notified first.

Background: books and readers should be added to the database

  Given these books exist:
  |title     |author |total_num |remain_num |description |
  |Sunshine  |Bob    |3         |3          |Wangwang    |
  |Moonlight |Alice  |2         |0          |Miaomiao    |
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

  Given I login as normal user with jobid "2010010002", name "Tom", email "hi@g.com"

Scenario: some reserve a book when no remains
  Given I am on the details page for "Moonlight"
  When I press "reserve_button"
  Then I should see "Reserved successfully"
  And I should see "取消预定" button

Scenario: some unreserve a book
  Given I am on the details page for "Moonlight"
  And I press "reserve_button"
  And I press "unreserve_button"
  Then I should see "Unreserved successfully"
  And I should see "预定" button

