require 'pry'
require 'date'

class Runner
  def run
    puts "Welcome!  We need to collect some information from you - don't worry, your data will be secure... as it will be forgotten once the program is closed."
    sleep 1
    puts "What is the total amount of money you have to spend until the semester is over? (Please enter an integer):"
    bank_account = gets.chomp
    puts "What is your monthly rent? (Please enter an integer):"
    rent = gets.chomp
    puts "What are your combined monthly utilities, e.g. electric, wireless, etc.? (Please enter an integer):"
    utilities = gets.chomp
    puts "Are there any other expected expences? Please aggregate. (Please enter an integer, 0 if none):"
    other_expenses = gets.chomp
    puts "Do you want to end the semester with a certain amount of extra money to float you to employment? (Please enter an integer, 0 if none):"
    cushion = gets.chomp
    puts "Thanks for the info..."
    puts "Working on keeping you off the streets, hand tight!"

    @user_budget = Budget.new(bank_account, rent, utilities, other_expenses, cushion) #remove @
    sleep 1
    gear_box
  end

  def gear_box
    puts "What would you like to see?"
    puts "I accept the following commands:\n- time table : displays days and weeks left in the semester\n- available spend : displays data about how much money you can spend per day and week\n- exit : exits this program"
    command = gets.chomp.downcase

    if command == "exit"
      exit
    elsif command == "time table"
      @user_budget.time_table
      gear_box
    elsif command == "available spend"
      @user_budget.bank_after_known_expenses
      @user_budget.available_spend
      gear_box
    else
      puts "Please enter a valid command"
      gear_box
    end
  end

  def exit
    #exit
  end
end

class Budget
  def initialize(bank_account, rent, utilities, other_expenses, cushion)
    @bank_account = bank_account.to_i
    @rent = rent.to_i
    @utilities = utilities.to_i
    @other_expenses = other_expenses.to_i
    @cushion = cushion.to_i
    @date_today = Date.today
    @date_graduation = Date.parse("2016-02-26")
    @days_remaining = (@date_graduation - @date_today).to_i
    @weeks_remaining = (@days_remaining / 7).to_i
  end

  def time_table
    puts "Today's date is #{@date_today.to_s}. The last day of our Flatiron School Semester is #{@date_graduation.to_s}, which means we have #{@days_remaining.to_s} days left of the semster, or #{@weeks_remaining.to_s} weeks."
    sleep 1
  end

  def bank_after_known_expenses
    @bank_after = (@bank_account - ((@rent * (@weeks_remaining/4)) + (@utilities * (@weeks_remaining/4)) + @other_expenses + @cushion)).to_i
    puts "Only including known expenses, at the end of the semester you will have $#{@bank_after}."
    if @cushion > 0
      puts "Plus a cushion of $#{@cushion}"
    end
    sleep 1
  end

  def available_spend
    #binding.pry
    @spend_week = (@bank_after / @weeks_remaining)
    @spend_day = (@bank_after / @days_remaining)
    puts "Based on your entries, you can spend $#{@spend_week} per week or $#{@spend_day} per day."
    sleep 1
    puts "God speed."
    sleep 2

    if @spend_day < 10
      system "open https://www.youtube.com/watch?v=yTN9jn8_FZ0"
      system "open http://www.maruchan.com/"
      system "open https://www.gofundme.com/"
    elsif @spend_day > 50
      system "open https://45.media.tumblr.com/eadee3b77f54d8544584303b4476c6af/tumblr_mi61oxs58R1qz6z6zo1_500.gif"
    else
    end
  end
end

begin_program = Runner.new
begin_program.run
