# Method to calculate grade
def calculate_grade(score)
  case score
  when 90..100
    "A"
  when 75..89
    "B"
  when 60..74
    "C"
  when 50..59
    "D"
  else
    "F"
  end
end

# List of students
students = [
  { name: "Alice", score: 92 },
  { name: "Bob", score: 78 },
  { name: "Charlie", score: 65 },
  { name: "David", score: 48 }
]

# Display summary
puts "Student Details Summary"
puts "-----------------------------"

students.each do |student|
  grade = calculate_grade(student[:score])

  puts "Name  : #{student[:name]}"
  puts "Score : #{student[:score]}"
  puts "Grade : #{grade}"
  puts "-----------------------------"
end