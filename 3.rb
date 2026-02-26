# Simple Ruby Vending Machine

products = {
  1 => { name: "Soda", price: 2.5 },
  2 => { name: "Chips", price: 1.5 },
  3 => { name: "Chocolate", price: 3.0 }
}

puts "Welcome to the Ruby Vending Machine!"

loop do
  puts "\nAvailable Products:"
  products.each do |number, product|
    puts "#{number}. #{product[:name]} - $#{product[:price]}"
  end
  puts "Type 'cancel' anytime to cancel."

  # Product Selection
  choice = nil
  loop do
    print "Select product (1-3): "
    input = gets.chomp

    if input.downcase == "cancel"
      puts "Transaction cancelled."
      break
    end

    choice = input.to_i

    if products.key?(choice)
      break
    else
      puts "Invalid selection. Try again."
    end
  end

  next if choice.nil? || !products.key?(choice)

  selected_product = products[choice]

  # Quantity
  print "Enter quantity: "
  quantity_input = gets.chomp

  if quantity_input.downcase == "cancel"
    puts "Transaction cancelled."
    next
  end

  quantity = quantity_input.to_i

  if quantity <= 0
    puts "Invalid quantity."
    next
  end

  total_price = selected_product[:price] * quantity
  puts "Total price: $#{total_price}"

  # Money Insertion
  money_inserted = 0.0

  while money_inserted < total_price
    print "Insert money: "
    money_input = gets.chomp

    if money_input.downcase == "cancel"
      puts "Transaction cancelled."
      puts "Returning $#{money_inserted}"
      money_inserted = 0
      break
    end

    money_inserted += money_input.to_f

    if money_inserted < total_price
      puts "Not enough money. Still need $#{(total_price - money_inserted).round(2)}"
    end
  end

  next if money_inserted == 0

  change = (money_inserted - total_price).round(2)

  # Transaction Summary
  puts "\n=== Transaction Summary ==="
  puts "Product: #{selected_product[:name]}"
  puts "Quantity: #{quantity}"
  puts "Total Paid: $#{money_inserted}"
  puts "Change Returned: $#{change}"
  puts "Thank you for your purchase!"

  # Multiple Transactions
  print "\nDo you want to buy another product? (yes/no): "
  answer = gets.chomp.downcase
  break if answer != "yes"
end

puts "Goodbye!"


######

class Person
  attr_reader :name,:hobbies

  def initialize(name,hobbies_string)
    @name=name
    set_hobbies(hobbies_string)
  end


  def set_hobbies(hobbies_string)
    @hobbies=hobbies_string.split(",").map{|h| h.strip.downcase}
  end

  def common_hobbies(other_person)
    @hobbies & other_person.hobbies
  end

  def find_matches(people)
    matches = []

    people.each do |person|
      next if person == self

      shared=common_hobbies(person)

      if shared.any?
        matches << {person:person,shared:shared}
      end
    end

    matches.sort_by {|m| -m[:shared].length}
  end
end


john = Person.new("John", "Go, Geocaching, Bicycles")
mary = Person.new("Mary", "Go, Chess, Bicycles")
alex = Person.new("Alex", "Football, Chess")
emma = Person.new("Emma", "Go, Geocaching, Chess")

people = [john, mary, alex, emma]

matches = john.find_matches(people)

matches.each do |match|
  puts "#{match[:person].name} shares: #{match[:shared].join(", ")}"
end


####


prices =[10,20,100,5000,30]

def calculate_total(prices)
  total=0
  prices.each do |price|
    total+=price
  end
  return total
end

def cal_disc(prices)
  total=0
  prices.each do |price|
    total+=price/3.0
  end
  return total
end

# Display results
puts "Prices in this order: #{prices}"
puts "Total of prices: #{calculate_total(prices)}"
puts "Total discount (1/3 off each price): #{cal_disc(prices)}"


#####



secret_number=rand(100)+1

max_attempts=10
attempts=0
correct=false

puts "Welcome to guess the random number"

while attempts<max_attempts

  print "\nEnter the guess: "
  no_input=gets.chomp.to_i

  attempts+=1

  if secret_number==no_input
    puts "You guessed Crtly"
    correct=true
    break
  elsif no_input<secret_number
    puts "low..try again"
  else
    puts "high..try again"
  end
  puts "Attempts left:#{max_attempts-attempts}"
end

unless correct
  "Sorry u lose"
end



####


class Media
  attr_reader :comments

  def initialize
    @comments=[]
  end

  def add_comments(comment)
    @comments.push(comment)
  end

  def play
    puts "Playing...."
  end
end

class Video < Media
  attr_accessor :resolution

  def initialize(resolution)
    super()
    @resolution =resolution
  end
end

class Music < Media

  attr_accessor :bpm

  def initialize(bpm)
    super()
    @bpm=bpm
  end
end

v1=Video.new("1080p")

m1=Music.new(200)

v1.add_comments("Awesomee")
m1.add_comments("On loop...")

v1.play
m1.play

puts v1.comments
puts m1.comments


#####


def calculate_cart(cart)
  total=0

  cart.each do |product|
    pro=product[0]
    quantity=product[1]
    price=product[2]

    if quantity>5
      price=price-price*0.1
    end
    
    total+=quantity*price
  end
  
    return total
end
puts calculate_cart([ ["Laptop", 1, 800], ["Headphones", 6, 50], ["Mouse", 3, 25] ])



######

library = {
  "978-0143127741" => { title: "The Alchemist", author: "Paulo Coelho", copies: 5 },
  "978-0062315007" => { title: "Sapiens", author: "Yuval Noah Harari", copies: 3 },
  "978-0451524935" => { title: "1984", author: "George Orwell", copies: 4 }
}

# Add Book
print "Enter the new book's title: "
title = gets.chomp

print "Enter the author's name: "
author = gets.chomp

print "Enter the ISBN: "
isbn = gets.chomp

print "Enter number of copies: "
copies = gets.chomp.to_i

library[isbn] = { title: title, author: author, copies: copies }
puts "New book added!"

# Update Copies
print "Enter ISBN to update copies: "
update_isbn = gets.chomp

if library.key?(update_isbn)
  print "Enter new number of copies: "
  library[update_isbn][:copies] = gets.chomp.to_i
  puts "Book copies updated!"
end

# Remove Book
print "Enter ISBN to remove: "
remove_isbn = gets.chomp

if library.delete(remove_isbn)
  puts "Removed book with ISBN: #{remove_isbn}"
  puts "Book removed successfully!"
end

# Search Book
print "Enter ISBN to search: "
search_isbn = gets.chomp

if library.key?(search_isbn)
  book = library[search_isbn]
  puts "Title: #{book[:title]}"
  puts "Author: #{book[:author]}"
  puts "Copies Available: #{book[:copies]}"
end

# List All Books
puts "\nLibrary Catalog:"
library.each do |isbn, details|
  puts "#{isbn} | #{details[:title]} | #{details[:author]} | Copies: #{details[:copies]}"
end

####


students = [
  ["Alice", "S001", [85, 90, 78]],
  ["Bob", "S002", [75, 80, 88]],
  ["Charlie", "S003", [90, 92, 95]]
]

# Add Student
print "Enter the new student's name: "
name = gets.chomp

print "Enter the student's ID: "
id = gets.chomp

print "Enter the student's grades (space separated): "
grades = gets.chomp.split.map(&:to_i)

students << [name, id, grades]
puts "New student added!"

# Update Grades
print "Enter the student ID to update grades: "
update_id = gets.chomp

students.each do |student|
  if student[1] == update_id
    print "Enter the new grades: "
    student[2] = gets.chomp.split.map(&:to_i)
    puts "Student grades updated!"
  end
end

# Remove Student
print "Enter the student ID to remove: "
remove_id = gets.chomp

students.reject! do |student|
  if student[1] == remove_id
    puts "Removed student with ID: #{remove_id}"
    true
  else
    false
  end
end

puts "Student removed successfully!"

# Calculate Average
print "Enter the student ID to calculate average grade: "
avg_id = gets.chomp

students.each do |student|
  if student[1] == avg_id
    avg = student[2].sum.to_f / student[2].length
    puts "Average grade for #{student[0]}: #{avg.round(2)}"
  end
end

# Array slicing
print "Enter start and end index: "
start_index, end_index = gets.chomp.split.map(&:to_i)

subset = students[start_index..end_index]

subset.each do |student|
  avg = student[2].sum.to_f / student[2].length
  puts "#{student[0]} (ID: #{student[1]}) - Average Grade: #{avg.round(2)}"
end

# Display full gradebook
puts "\nGradebook:"
students.each do |student|
  avg = student[2].sum.to_f / student[2].length
  puts "#{student[0]} | #{student[1]} | #{student[2].join(', ')} | Avg: #{avg.round(2)}"
end


###


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


####


# -----------------------------------------
# GAME CHARACTER SYSTEM USING MIXINS
# -----------------------------------------

# ----------------------------
# Common Combat Abilities Mixin
# ----------------------------
module CombatAbilities
  def move
    puts "#{@name} is moving"
  end

  def attack
    puts "#{@name} attacks with power #{@attack}"
  end

  def defend
    puts "#{@name} defends with strength #{@defense}"
  end
end

# ----------------------------
# Unique Ability Mixins
# ----------------------------
module Healing
  def heal
    puts "#{@name} uses healing ability!"
  end
end

module Poison
  def poison
    puts "#{@name} uses poison attack!"
  end
end

# ----------------------------
# Level Up Mixin
# ----------------------------
module LevelUp
  def level_up
    @level += 1
    @attack += 5
    @defense += 3

    puts "#{@name} leveled up!"
    puts "Level: #{@level}"
    puts "Attack: #{@attack}"
    puts "Defense: #{@defense}"
  end
end

# ----------------------------
# Base Character Class
# ----------------------------
class Character
  attr_reader :name, :level, :attack, :defense

  def initialize(name)
    @name = name
    @level = 1
    @attack = 10
    @defense = 5
  end
end

# ----------------------------
# Hero Class
# ----------------------------
class Hero < Character
  include CombatAbilities
  include Healing
  include LevelUp
end

# ----------------------------
# Villain Class
# ----------------------------
class Villain < Character
  include CombatAbilities
  include Poison
  include LevelUp
end

# ----------------------------
# Monster Class
# ----------------------------
class Monster < Character
  include CombatAbilities
  include LevelUp
end

# -----------------------------------------
# Demonstration Section
# -----------------------------------------

hero = Hero.new("Archer")
villain = Villain.new("Dark Lord")
monster = Monster.new("Goblin")

puts "\n--- HERO ACTIONS ---"
hero.move
hero.attack
hero.heal
hero.level_up

puts "\n--- VILLAIN ACTIONS ---"
villain.move
villain.attack
villain.poison
villain.level_up

puts "\n--- MONSTER ACTIONS ---"
monster.move
monster.defend
monster.level_up