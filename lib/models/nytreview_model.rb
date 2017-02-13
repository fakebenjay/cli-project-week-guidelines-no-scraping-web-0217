class Model

  attr_accessor :display_title, :rating, :critics_pick, :byline, :short_summary, :review_url, :opening_date

  @@trivia_hash = {}

  def initialize(display_title,rating,critics_pick,byline,short_summary,review_url,opening_date,number=0)
    @display_title = display_title
    @rating = rating
    @critics_pick = critics_pick
    @byline = byline
    @short_summary = short_summary
    @review_url = review_url
    @opening_date = opening_date
    @number = number
  end

  def display_information
    puts "Booyakasha" +  "\n" + "\n"
    puts "Film: #{@display_title}" + "\n" + "\n"
    if @rating == ""
      puts "This movie has not been rated."
    else
      puts "MPAA Rating: #{@rating}" + "\n" + "\n"
    end
    if @critics_pick == 1
      puts "Critic Recommended" + "\n" + "\n"
    else
      puts "Not Critic Recommended" + "\n" + "\n"
    end
    puts "Reviewer: #{@byline}"  + "\n" + "\n"
    puts "Synopsis: #{@short_summary}" + "\n" + "\n"
    puts "Read more here: #{@review_url}" +"\n" + "\n"
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
    puts "\n \nCan you guess what movies these movies came out from the years listed below?"
      movie_titles.map.with_index(1) do |title, index|
        puts "#{index}. #{title}"
      end
    puts "\nPlease type in the year you believe these movies opened:\n \n"
      opening_years.each.with_index(1) do |year, index|
        if index == rand(0..3)
          puts "#{index}. #{year}"
        else
          puts "#{index}. #{(year += rand(-5..5))}"
        end
      end
    user_selection = gets.chomp.strip
    if user_selection.to_i == opening_years[0]
      puts "You are correct!"
      # user_choice = gets.chomp
    #   if user_choice == "Y"
    #     ReviewAPI.trivia
    #   elsif user_choice == "N"
    #     NYTimesReviewCLI.run
    #   else
    #     "Please type Y or N"
    #   end
    else
      puts "Sorry, that is incorrect!"
    #   user_choice = gets.chomp
    #   if user_choice == "Y"
    #     ReviewAPI.trivia
    #   elsif user_choice == "N"
    #     exit
    #   else
    #     "Please type Y or N"
    end
  end

    def self.trivia_hash
      @@trivia_hash
    end

end
