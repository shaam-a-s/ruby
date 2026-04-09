# Book class
class Book
  attr_accessor :title, :author, :available

  def initialize(title, author)
    @title = title
    @author = author
    @available = true
  end
end

# Library class
class Library
  def initialize
    @books = []
  end

  # Add book
  def add_book(book)
    @books << book
    puts "#{book.title} added to library."
  end

  # Display books
  def display_books
    puts "\nLibrary Books:"
    @books.each do |book|
      status = book.available ? "Available" : "Borrowed"
      puts "#{book.title} by #{book.author} - #{status}"
    end
  end

  # Borrow book
  def borrow_book(title)
    book = @books.find { |b| b.title.downcase == title.downcase }

    if book && book.available
      book.available = false
      puts "You borrowed '#{book.title}'"
    else
      puts "Book not available"
    end
  end

  # Return book
  def return_book(title)
    book = @books.find { |b| b.title.downcase == title.downcase }

    if book && !book.available
      book.available = true
      puts "You returned '#{book.title}'"
    else
      puts "Invalid return"
    end
  end
end

# Create library
library = Library.new

# Add books
library.add_book(Book.new("Ruby Basics", "Matz"))
library.add_book(Book.new("Learn Rails", "David"))
library.add_book(Book.new("OOP Concepts", "James"))

# Display books
library.display_books

# Borrow book
library.borrow_book("Ruby Basics")

# Display again
library.display_books

# Return book
library.return_book("Ruby Basics")

# Final display
library.display_books