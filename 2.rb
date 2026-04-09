class LibraryItem
  attr_accessor :title, :author, :publication_year

  def initialize(title, author, publication_year)
    @title = title
    @author = author
    @publication_year = publication_year
  end

  def due_date
    Date.today + 14   # default 14-day loan
  end
end

require 'date'

class Book < LibraryItem
  attr_accessor :isbn, :number_of_pages

  def initialize(title, author, publication_year, isbn, number_of_pages)
    super(title, author, publication_year)
    @isbn = isbn
    @number_of_pages = number_of_pages
  end
end

class DVD < LibraryItem
  attr_accessor :running_time, :genre

  def initialize(title, author, publication_year, running_time, genre)
    super(title, author, publication_year)
    @running_time = running_time
    @genre = genre
  end

  # Override due_date for shorter period
  def due_date
    Date.today + 7
  end
end

class Magazine < LibraryItem
  attr_accessor :issue_number, :publisher

  def initialize(title, author, publication_year, issue_number, publisher)
    super(title, author, publication_year)
    @issue_number = issue_number
    @publisher = publisher
  end
end


book = Book.new("Ruby Basics", "John Doe", 2020, "123-ABC", 350)
dvd = DVD.new("Inception", "Christopher Nolan", 2010, 148, "Sci-Fi")
magazine = Magazine.new("Tech Today", "Editor Team", 2024, 45, "TechPress")

puts book.isbn
puts dvd.genre
puts magazine.publisher

puts book.due_date
