# Parent class
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def introduce
    "Hi, I am #{@name} #{@age} years old."
  end
end

# Child class - Student
class Student < Person
  attr_accessor :student_id

  def initialize(name, age, student_id)
    super(name, age)
    @student_id = student_id
  end

  # Method overriding
  def introduce
    "Hi, I am #{@name} #{@age} years old. My student id is #{@student_id}"
  end
end

# Child class - Teacher
class Teacher < Person
  attr_accessor :subject

  def initialize(name, age, subject)
    super(name, age)
    @subject = subject
  end

  # Method overriding
  def introduce
    "Hi, I am #{@name} #{@age} years old. I am teaching #{@subject}."
  end
end

# Creating objects
student = Student.new("alice", 20, "S101")
teacher = Teacher.new("mr. Kumar", 40, "mathematics")

# Output
puts student.introduce
puts
puts teacher.introduce