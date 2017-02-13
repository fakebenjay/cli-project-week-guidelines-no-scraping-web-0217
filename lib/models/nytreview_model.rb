class Model

  attr_accessor :display_title, :publication_date, :rating, :critics_pick, :byline, :short_summary, :review_url,:opening_date

  @@trivia_hash = {}
  @@opening_years = []
  @@quiz_years = []
  @@correct_answer = 0

  def initialize(display_title,publication_date,rating,critics_pick,byline,short_summary,review_url,opening_date,number=0)
    @display_title = display_title
    @publication_date = publication_date
    @rating = rating
    @critics_pick = critics_pick
    @byline = byline
    @short_summary = short_summary
    @review_url = review_url
    @opening_date = opening_date
    @number = number
  end

  def display_information
    puts ""
    puts "Booyakasha" + "\n" + "\n"
    139.times do
      print "-"
    end
    puts ""
    sleep(0.5)
    puts "Film: #{@display_title}" + "\n"
    puts "Review date: #{@publication_date}" + "\n"
    puts "MPAA Rating: #{@rating}" + "\n"
    if @critics_pick == 1
      puts "Critics' Pick" + "\n"
    end
    puts "Reviewer: #{@byline}" + "\n"
    puts "Synopsis: #{@short_summary}" + "\n"
    puts "Read more here: #{@review_url}" + "\n" + "\n"
  end

  def populating_trivia_hash
    if opening_date
      string_date = @opening_date.slice(0..3)
      formatted_date = string_date.to_i
      @@trivia_hash[@display_title] = formatted_date
    end
  end

  def self.play_trivia
    movie_titles = @@trivia_hash.keys
    @@opening_years = @@trivia_hash.values
    puts "\n \nCan you guess what year the movies below came out?\n\n"
      movie_titles.map.with_index(1) do |title, index|
        puts "#{index}. #{title}"
      end
        self.print_line
        self.ensure_quiz_years_unique
        @@quiz_years.each do |year|
          puts year
        end

      self.are_they_right?
  end


    def self.are_they_right?
      @@correct_answer = @@opening_years[0]
      puts "\nPlease type in the year you believe these movies opened in theatres:\n \n"
      user_selection = gets.chomp.strip
      user_selection = user_selection.to_i
        if user_selection.to_s == "exit"
          exit
        elsif @@quiz_years.include?(user_selection)
          self.data_validator_and_response(user_selection)
        else
          puts "Not a valid response. Please try again"
          user_selection = gets.chomp.strip
          user_selection = user_selection.to_i
          self.data_validator_and_response(user_selection)
        end
    end



    def self.populate_quiz_years_array
      @@opening_years.map.with_index(1) do |year, index|
        if index == rand(1..4)
          year
        elsif year == Time.new.year
           year += rand(-10..0)
        elsif year == Time.new.year - 1
           year += rand(-9..1)
        elsif year == Time.new.year - 2
           year += rand(-8..2)
        elsif year == Time.new.year - 3
           year += rand(-7..3)
        elsif year == Time.new.year - 4
           year += rand(-6..4)
        else
           year += rand(-5..5)
        end
      end
    end

    def self.ensure_quiz_years_unique
      @@quiz_years = self.populate_quiz_years_array
      until @@quiz_years.uniq.length == 4
        @@quiz_years = self.populate_quiz_years_array
      end
      @@quiz_years
    end

    def self.play_again?
      puts "Please select from the following options:\n1. Play Again\n2. Main Menu"
      user_choice = gets.chomp
     if user_choice.to_s.downcase == "play again" || user_choice.to_i == 1
        @@trivia_hash = {}
        @@opening_years.clear
        @@quiz_years.clear
        ReviewCLI.trivia
     elsif user_choice.to_s.downcase == "main menu"|| user_choice.to_i == 2
        ReviewCLI.new
      else
        "Please enter a valid response."
      end
    end

    def self.data_validator_and_response(user_selection)
      if user_selection.to_i == @@correct_answer
        puts ""
        puts "\nYou are correct!"
        puts ""
        sleep(1)
        self.play_again?
      elsif @@quiz_years.include?(user_selection.to_i) && user_selection.to_i > 0
        puts ""
        puts "\nSorry, that is incorrect! The correct answer is #{@@correct_answer}\n"
        puts ""
        sleep(1)
      self.play_again?
      end
    end

    def self.trivia_hash
        @@trivia_hash
    end

    def self.opening_years
        @@opening_years
    end

    def self.quiz_years
      @@quiz_years
    end

    def self.print_line
      puts ""
      60.times do
        print "-"
      end
      puts ""
    end

end
