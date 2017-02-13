class Model

  attr_accessor :display_title, :publication_date, :rating, :critics_pick, :byline, :short_summary, :review_url,:opening_date

  @@trivia_hash = {}

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
    puts "Booyakasha" + "\n" + "\n"
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
    opening_years = @@trivia_hash.values
    puts "\n \nCan you guess what year the movies below came out?\n\n"
      movie_titles.map.with_index(1) do |title, index|
        puts "#{index}. #{title}"
      end
    puts "\nPlease type in the year you believe these movies opened in theatres, or type exit to quit the program:\n \n"
      opening_years.each.with_index(1) do |year, index|
        if index == rand(1..4)
          puts "#{year}"
        elsif year == Time.new.year
          puts "#{(year += rand(-10..0))}"
        elsif year == Time.new.year - 1
          puts "#{(year += rand(-9..1))}"
        elsif year == Time.new.year - 2
          puts "#{(year += rand(-8..2))}"
        elsif year == Time.new.year - 3
          puts "#{(year += rand(-7..3))}"
        elsif year == Time.new.year - 4
          puts "#{(year += rand(-6..4))}"
        else
          puts "#{(year += rand(-5..5))}"
        end
      end
      60.times do
        print "-"
      end 
    puts "\nYour Guess:"
    user_selection = gets.chomp.strip
    if user_selection.to_i == opening_years[0]
      puts "\nYou are correct!"
      # user_choice = gets.chomp
    #   if user_choice == "Y"
    #     ReviewAPI.trivia
    #   elsif user_choice == "N"
    #     NYTimesReviewCLI.run
    #   else
    #     "Please type Y or N"
    #   end
    @@trivia_hash = {}
  elsif user_selection.to_i > 0
      puts "\nSorry, that is incorrect! The correct answer is #{opening_years[0]}"
    #   user_choice = gets.chomp
    #   if user_choice == "Y"
    #     ReviewAPI.trivia
    #   elsif user_choice == "N"
    #     exit
    #   else
    #     "Please type Y or N
    @@trivia_hash = {}
  elsif user_selection.downcase == 'exit'
    exit
  else
    "Please enter a valid year."
    end
  end

    def self.trivia_hash
      @@trivia_hash
    end

end
