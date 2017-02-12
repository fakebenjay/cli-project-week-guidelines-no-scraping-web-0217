class Model

  attr_accessor :display_title, :rating, :critics_pick, :byline, :short_summary, :review_url, :opening_date

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

  def populating_trivia_array
    trivia_array = []
    opening_date_in_array = []
    trivia_array << self.display_title
    opening_date_in_array << self.opening_date[0..3].to_i
    user_input = gets.chomp.to_i
    random_index = rand(0..answer_array.count)
    opening_date_in_array.drop(random_index).map do |year|
      year += rand(-5..5)
    end 
  end

end
