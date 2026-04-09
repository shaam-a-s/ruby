# Superclass
class Vehicle
  attr_accessor :make, :model, :year

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def details
    "Make: #{@make}, Model: #{@model}, Year: #{@year}"
  end
end

# Subclass - Car
class Car < Vehicle
  def vehicle_type
    "Car"
  end

  # Override method
  def details
    "#{vehicle_type} - #{super}"
  end
end

# Subclass - Bike
class Bike < Vehicle
  def vehicle_type
    "Bike"
  end

  # Override method
  def details
    "#{vehicle_type} - #{super}"
  end
end

# Subclass - Truck
class Truck < Vehicle
  def vehicle_type
    "Truck"
  end

  # Override method
  def details
    "#{vehicle_type} - #{super}"
  end
end

# Creating objects
car = Car.new("Toyota", "Corolla", 2022)
bike = Bike.new("Yamaha", "R15", 2021)
truck = Truck.new("Tata", "1618", 2020)

# Display details
puts car.details
puts bike.details
puts truck.details