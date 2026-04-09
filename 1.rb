```ruby
# product.rb

class Product
  attr_reader :id, :name, :price

  @@next_id = 1

  def initialize(name:, price:)
    @id    = @@next_id
    @@next_id += 1
    @name  = name
    @price = price
  end

  def to_s
    "#{name} ($#{'%.2f' % price})"
  end
end

class Book < Product
  attr_reader :author, :isbn

  def initialize(title:, price:, author:, isbn:)
    super(name: title, price: price)
    @author = author
    @isbn   = isbn
  end

  def to_s
    "#{super} by #{author} (ISBN: #{isbn})"
  end
end

class Clothing < Product
  attr_reader :size, :material

  def initialize(name:, price:, size:, material:)
    super(name: name, price: price)
    @size     = size
    @material = material
  end

  def to_s
    "#{super} – Size: #{size}, Material: #{material}"
  end
end

module So
    def gretam
        puts "Vannakaam"
    end
end

class Person
    def initialize(name,age)
        @name=name
        @age=age
    end

    def greet
        puts "Hi I am #{@name}"
    end
end

class Student < Person
    def study
        puts "#{@name} is Studying"
    end
    include So 
end

# Demonstration
if __FILE__ == $0
  book  = Book.new(title: "The Ruby Way", price: 39.99, author: "Hal Fulton", isbn: "978-1593278231")
  shirt = Clothing.new(name: "T‑Shirt", price: 19.99, size: "M", material: "Cotton")

  puts book
  puts shirt

  p1=Student.new("Shaam",20)
  p1.greet
  p1.study
  p1.gretam
end
```
