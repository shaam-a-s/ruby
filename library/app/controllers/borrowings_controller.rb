class BorrowingsController < ApplicationController
  def index
    @borrowings = Borrowing.all
  end
  def create
    book = Book.find(params[:book_id])
    borrower = Borrower.find(params[:borrower_id])

    if book.available
      Borrowing.create(
        book: book,
        borrower: borrower,
        borrowed_on: Date.today
      )

      book.update(available: false)
    end

    redirect_to books_path
  end

  def return_book
    borrowing = Borrowing.find(params[:id])
    borrowing.update(returned_on: Date.today)

    borrowing.book.update(available: true)

    redirect_to books_path
  end
end