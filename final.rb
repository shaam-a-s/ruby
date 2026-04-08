# VENDING MACHINE SYSTEM

puts "--Vending Machine--"
puts "Press 0 anytime to cancel the Transaction"
print "\n"

def cancel(refund)
  puts "Transaction Cancelled"
  puts "Refunded amount Rs.#{refund}" if refund > 0
end

loop do
  products = {
    Juice: 30,
    Biscuit: 20,
    Chocolate: 10
  }

  products.each do |key, value|
    puts "#{key} : Rs.#{value}"
  end

  total_amt = 0
  choice = nil
  quantity = 0
  inserted = 0

  loop do
    print "\nEnter item (1-juice, 2-Biscuit, 3-Chocolate): "
    choice = gets.chomp.to_i

    if choice == 0
      cancel(inserted)
      exit
    elsif choice > 3
      puts "Invalid choice. Try again"
    else
      print "Enter the quantity: "
      quantity = gets.chomp.to_i

      if quantity == 0
        cancel(inserted)
        exit
      end

      key = products.keys
      price = products[key[choice - 1]]
      total_amt += quantity * price
      puts "Total amount : #{total_amt}"
      break
    end
  end

  print "Insert amount: "
  inserted = gets.chomp.to_i

  if inserted == 0
    cancel(inserted)
    exit
  end

  change = 0

  while inserted < total_amt
    print "Inserted money not enough(needed Rs.#{total_amt - inserted}): "
    money = gets.chomp.to_i

    if money == 0
      cancel(inserted)
      exit
    end

    inserted += money
  end

  change = inserted - total_amt if inserted > total_amt

  puts "\n---Transaction Details---"
  puts "Selected product: #{products.keys[choice - 1]}"
  puts "Quantity purchased: #{quantity}"
  puts "Total amount: #{total_amt}"
  puts "Total amount paid: #{inserted}"
  puts "Change returned: #{change}"

  print "\nDo you want to purchase again(yes/no): "
  again = gets.chomp.downcase
  break if again != "yes"
end

puts "\nThanks for Purchasing"

# XMART DISCOUNT SYSTEM

print "Enter the total amount you have been purchased: "
amount = gets.chomp.to_i
final_amt = 0

if amount > 1000 && amount <= 2000
  puts "You have 5% Discount"
  final_amt += amount - (amount * 0.05)
elsif amount > 2000 && amount <= 5000
  puts "You have 10% Discount"
  final_amt += amount - (amount * 0.10)
elsif amount > 5000
  puts "You have 15% Discount"
  final_amt += amount - (amount * 0.15)
else
  puts "You have no Discount"
  final_amt += amount
end

puts "Total amount that you have purchased #{amount}"
puts "Total amount after your Discount #{final_amt}"

# EMPLOYEE WAGE CALCULATION

print "Enter number of days you have worked: "
days = gets.chomp.to_i

loop do
  print "Enter your Age: "
  age = gets.chomp.to_i

  if age >= 19 && age <= 30
    print "Enter your Gender: "
    gender = gets.chomp

    if gender.downcase == "male"
      puts "Your salary is #{days * 800}"
      break
    else
      puts "Your salary is #{days * 850}"
      break
    end

  elsif age >= 31 && age <= 40
    print "Enter your Gender: "
    gender = gets.chomp

    if gender.downcase == "male"
      puts "Your salary is #{days * 900}"
      break
    else
      puts "Your salary is #{days * 950}"
      break
    end

  else
    puts "Enter appropriate age(19 to 40)"
  end
end

# EMPLOYEE WAGE CALCULATION

print "Enter number of days you have worked: "
days = gets.chomp.to_i

loop do
  print "Enter your Age: "
  age = gets.chomp.to_i

  if age >= 19 && age <= 30
    print "Enter your Gender: "
    gender = gets.chomp

    if gender.downcase == "male"
      puts "Your salary is #{days * 800}"
      break
    else
      puts "Your salary is #{days * 850}"
      break
    end

  elsif age >= 31 && age <= 40
    print "Enter your Gender: "
    gender = gets.chomp

    if gender.downcase == "male"
      puts "Your salary is #{days * 900}"
      break
    else
      puts "Your salary is #{days * 950}"
      break
    end

  else
    puts "Enter appropriate age(19 to 40)"
  end
end

# EMPLOYEE WAGE CALCULATION

print "Enter number of days you have worked: "
days = gets.chomp.to_i

loop do
  print "Enter your Age: "
  age = gets.chomp.to_i

  if age >= 19 && age <= 30
    print "Enter your Gender: "
    gender = gets.chomp

    if gender.downcase == "male"
      puts "Your salary is #{days * 800}"
      break
    else
      puts "Your salary is #{days * 850}"
      break
    end

  elsif age >= 31 && age <= 40
    print "Enter your Gender: "
    gender = gets.chomp

    if gender.downcase == "male"
      puts "Your salary is #{days * 900}"
      break
    else
      puts "Your salary is #{days * 950}"
      break
    end

  else
    puts "Enter appropriate age(19 to 40)"
  end
end

# SHOPPING CART

def cart_total(cart)
  total = 0.0

  cart.each do |item|
    name, quantity, price = item
    item_total = quantity * price

    if quantity > 5
      item_total *= 0.9
    end

    total += item_total
  end

  total
end

cart = []
puts "How many products?"
count = gets.to_i

count.times do
  puts "Enter product name:"
  name = gets.chomp
  puts "Enter quantity:"
  quantity = gets.to_i
  puts "Enter price:"
  price = gets.to_f
  cart << [name, quantity, price]
end

puts "Cart array:"
p cart

final_total = cart_total(cart)
puts "Final total: $#{final_total}"

# STUDENT GRADEBOOK

students = [
  ["Alice", "S001", [85, 90, 78]],
  ["Bob", "S002", [75, 80, 88]],
  ["Charlie", "S003", [90, 92, 95]]
]

def average(grades)
  grades.sum.to_f / grades.length
end

loop do
  puts
  puts "1. Add new student"
  puts "2. Update student grades"
  puts "3. Remove student"
  puts "4. Calculate average grade"
  puts "5. Display students (slice)"
  puts "6. Display full gradebook"
  puts "7. Exit"
  puts "Enter your choice:"

  choice = gets.to_i

  case choice
  when 1
    puts "Enter student's name:"
    name = gets.chomp
    puts "Enter student ID:"
    id = gets.chomp
    puts "Enter grades:"
    grades = gets.split.map(&:to_i)
    students << [name, id, grades]
    puts "New student added!"

  when 2
    puts "Enter student ID to update grades:"
    id = gets.chomp
    students.each do |student|
      if student[1] == id
        puts "Enter new grades:"
        student[2] = gets.split.map(&:to_i)
        puts "Student grades updated!"
      end
    end

  when 3
    puts "Enter student ID to remove:"
    id = gets.chomp
    students.reject! { |student| student[1] == id }
    puts "Student removed successfully!"

  when 4
    puts "Enter student ID to calculate average:"
    id = gets.chomp
    students.each do |student|
      if student[1] == id
        avg = average(student[2])
        puts "Average grade for #{student[0]}: #{format('%.2f', avg)}"
      end
    end

  when 5
    puts "Enter start and end index:"
    start_index, end_index = gets.split.map(&:to_i)
    students[start_index..end_index].each do |student|
      avg = average(student[2])
      puts "#{student[0]} (ID: #{student[1]}) - Average Grade: #{format('%.2f', avg)}"
    end

  when 6
    puts "Name Student ID Grades Average Grade"
    students.each do |student|
      grades = student[2].join(", ")
      avg = average(student[2])
      puts "#{student[0]} #{student[1]} #{grades} #{format('%.2f', avg)}"
    end

  when 7
    puts "Exiting program"
    break

  else
    puts "Invalid choice"
  end
end

# LIBRARY MANAGEMENT USING HASH

library = {
  "978-0143127741" => { title: "The Alchemist", author: "Paulo Coelho", copies: 5 },
  "978-0062315007" => { title: "Sapiens", author: "Yuval Noah Harari", copies: 3 },
  "978-0451524935" => { title: "1984", author: "George Orwell", copies: 4 }
}

loop do
  puts
  puts "1. Add new book"
  puts "2. Update book copies"
  puts "3. Remove book"
  puts "4. Search book by ISBN"
  puts "5. List all books"
  puts "6. Exit"
  puts "Enter your choice:"

  choice = gets.to_i

  case choice
  when 1
    puts "Enter the new book's title:"
    title = gets.chomp
    puts "Enter the author's name:"
    author = gets.chomp
    puts "Enter the ISBN:"
    isbn = gets.chomp
    puts "Enter the number of copies:"
    copies = gets.to_i
    library[isbn] = { title: title, author: author, copies: copies }
    puts "New book added!"

  when 2
    puts "Enter the ISBN to update copies:"
    isbn = gets.chomp
    if library.key?(isbn)
      puts "Enter the new number of copies:"
      library[isbn][:copies] = gets.to_i
      puts "Book copies updated!"
    else
      puts "Book not found!"
    end

  when 3
    puts "Enter the ISBN to remove:"
    isbn = gets.chomp
    if library.delete(isbn)
      puts "Removed book with ISBN: #{isbn}"
      puts "Book removed successfully!"
    else
      puts "Book not found!"
    end

  when 4
    puts "Enter the ISBN to search:"
    isbn = gets.chomp
    if library.key?(isbn)
      book = library[isbn]
      puts "Book Details:"
      puts "Title: #{book[:title]}"
      puts "Author: #{book[:author]}"
      puts "Copies Available: #{book[:copies]}"
    else
      puts "Book not found!"
    end

  when 5
    puts "Library Catalog:"
    puts "ISBN Title Author Copies"
    library.each do |isbn, book|
      puts "#{isbn} #{book[:title]} #{book[:author]} #{book[:copies]}"
    end

  when 6
    puts "Exiting program"
    break

  else
    puts "Invalid choice"
  end
end


# LIBRARY MANAGEMENT SYSTEM USING OOP

require 'date'

class LibraryItem
  attr_accessor :title, :author, :publication_year

  def initialize(title, author, publication_year)
    @title = title
    @author = author
    @publication_year = publication_year
  end

  def due_date
    Date.today + 14
  end
end

class Book < LibraryItem
  attr_accessor :isbn, :number_of_pages

  def initialize(title, author, publication_year, isbn, pages)
    super(title, author, publication_year)
    @isbn = isbn
    @number_of_pages = pages
  end
end

class DVD < LibraryItem
  attr_accessor :running_time, :genre

  def initialize(title, author, publication_year, running_time, genre)
    super(title, author, publication_year)
    @running_time = running_time
    @genre = genre
  end

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

book = Book.new("Ruby Basics", "Matz", 2022, "ISBN123", 300)
dvd = DVD.new("Inception", "Nolan", 2010, 148, "Sci-Fi")
magazine = Magazine.new("Tech Today", "Editor", 2024, 45, "TechPress")

puts "Book ISBN: #{book.isbn}"
puts "Book Due Date: #{book.due_date}"
puts "DVD Genre: #{dvd.genre}"
puts "DVD Due Date: #{dvd.due_date}"
puts "Magazine Publisher: #{magazine.publisher}"
puts "Magazine Due Date: #{magazine.due_date}"



# E-COMMERCE PRODUCT SYSTEM

class Product
  attr_accessor :name, :price, :description

  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end

  def discount
    @price * 0.10
  end
end

class BookProduct < Product
  attr_accessor :author, :isbn

  def initialize(name, price, description, author, isbn)
    super(name, price, description)
    @author = author
    @isbn = isbn
  end

  def discount
    @price * 0.05
  end
end

class Clothing < Product
  attr_accessor :size, :color

  def initialize(name, price, description, size, color)
    super(name, price, description)
    @size = size
    @color = color
  end

  def discount
    @price * 0.20
  end
end

book = BookProduct.new("Ruby Guide", 500, "Programming Book", "Matz", "ISBN999")
shirt = Clothing.new("T-Shirt", 1000, "Cotton Wear", "L", "Blue")

puts "Book Author: #{book.author}"
puts "Book Discount: #{book.discount}"
puts "Shirt Color: #{shirt.color}"
puts "Shirt Discount: #{shirt.discount}"


# GAME CHARACTER SYSTEM USING MIXINS

module CombatAbilities
  def move
    puts "#{self.class} is moving"
  end

  def attack
    puts "#{self.class} is attacking"
  end

  def defend
    puts "#{self.class} is defending"
  end
end

module Healing
  def heal
    puts "#{self.class} heals itself"
  end
end

module Poison
  def poison
    puts "#{self.class} uses poison attack"
  end
end

module LevelUp
  def level_up
    @level ||= 1
    @attack ||= 10
    @defense ||= 5
    @level += 1
    @attack += 5
    @defense += 3
    puts "#{self.class} leveled up!"
    puts "Level: #{@level}, Attack: #{@attack}, Defense: #{@defense}"
  end
end

class Hero
  include CombatAbilities
  include Healing
  include LevelUp
end

class Villain
  include CombatAbilities
  include Poison
  include LevelUp
end

class Monster
  include CombatAbilities
  include LevelUp
end

hero = Hero.new
villain = Villain.new
monster = Monster.new

hero.move
hero.heal
hero.level_up

villain.attack
villain.poison
villain.level_up

monster.defend
monster.level_up