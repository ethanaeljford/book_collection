require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Ethans Best Book Collection"
  end

  test "should create book" do
    visit books_url
    click_on "Add Book"

    fill_in "Title", with: @book.title
    fill_in "Author", with: @book.author
    fill_in "Price", with: @book.price
    fill_in "Published date", with: @book.published_date
    click_on "Create Book"

    assert_text "Book was successfully created"
  end

  test "should update Book" do
    visit book_url(@book)
    click_on "Edit this book", match: :first

    fill_in "Title", with: @book.title
    fill_in "Author", with: @book.author
    fill_in "Price", with: @book.price
    fill_in "Published date", with: @book.published_date

    click_on "Update Book"

    assert_text "Book was successfully updated"
    
  end

  test "should destroy Book" do
    visit book_url(@book)
    click_on "Delete this book", match: :first
    click_on "Yes Delete It"

    assert_text "Book was successfully destroyed"
  end
end
