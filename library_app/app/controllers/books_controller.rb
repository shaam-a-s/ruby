class BooksController < ApplicationController
  def index
    @books = Book.all

    File.open("books.txt", "w") do |file|
      @books.each do |book|
        file.puts "#{book.title}, #{book.author}, #{book.availability}"
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.availability = true
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def borrow
    @book = Book.find(params[:id])
    @book.update(availability: false)
    redirect_to books_path
  end

  def return_book
    @book = Book.find(params[:id])
    @book.update(availability: true)
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end