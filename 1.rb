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


p1=Student.new("Shaam",20)
p1.greet
p1.study
p1.gretam