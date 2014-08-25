require 'active_record'
require 'pry'

require './lib/employee'
require './lib/division'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def main_menu
  choice = nil
  until choice == 'e'
    system('clear')
    puts "Welcome to the Employee Tracker"
    puts "Press [1] for the employee menu"
    puts "Press[2] for the division menu"
    puts "Press [e] to exit"

    choice = gets.chomp.downcase

    case choice
    when '1'
      employee_menu
    when '2'
      division_menu
    when 'e'
      exit
    else
      puts "Sorry not a valid option"
    end
  end
end

def employee_menu
  user_input = nil
  until user_input == 'r'
    puts "***Employee Menu***"
    puts "Press [1] to add an employee"
    puts "Press [2] to list all employees"
    puts "Press [r] to return to the main menu"
    user_input = gets.chomp.downcase

    case user_input
    when '1'
      puts "Enter employee's full-name"
      employee_name = gets.chomp.downcase
      Employee.create(:name => employee_name.split.map(&:capitalize).join(" "))
    when '2'
      Employee.all.each {|person| puts person.name}
    when 'r'
      main_menu
    else
      puts "Not a valid option"
    end
  end
end

def division_menu
  user_input = nil
  until user_input == 'r'
    puts "***Division Menu***"
    puts "Press [1] to add a division"
    puts "Press [2] to list all divisions"
    puts "Press [3] to add an employee to a division"
    puts "Press [r] to return to the main menu"
    user_input = gets.chomp.downcase

    case user_input
    when '1'
      puts "Enter the division name"
      division_name = gets.chomp.downcase
      Division.create(:name => division_name.split.map(&:capitalize).join(" "))
    when '2'
      Division.all.each {|division| puts division.name}
    when '3'
      Division.all.each {|division| puts division.id.to_s + ": " + division.name}
      puts "Choose a division number to add an employee"
      user_division_choice = gets.chomp.to_i
      division_found = Division.find(user_division_choice)
      Employee.all.each { |person| puts person.id.to_s + ": " + person.name}
      puts "Choose an employee number to add to '#{division_found.name}'"
      user_employee_id = gets.chomp.to_i
      employee_found = Employee.find(user_employee_id)
      employee_found.update(division_id: user_division_choice)
    when 'r'
      main_menu
    else
      puts "Not a valid option"
    end
  end
end

main_menu
