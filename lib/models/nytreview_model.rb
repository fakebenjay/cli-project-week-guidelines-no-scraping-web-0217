class Model

  attr_accessor :display_title, :rating, :critics_pick, :byline, :short_summary, :review_url

  def initialize(display_title,rating,critics_pick,byline,short_summary,review_url,number=0)
    @display_title = display_title
    @rating = rating
    @critics_pick = critics_pick
    @byline = byline
    @short_summary = short_summary
    @review_url = review_url
    @number = number
  end

  def display_information
    puts "Booyakasha" +  "\n" + "\n"
    puts "Film: #{@display_title}" + "\n" + "\n"
    puts "MPAA Rating: #{@rating}" + "\n" + "\n"
    if @critics_pick == 1
      puts "Critic Recommended" + "\n" + "\n"
    else
      puts "Not Critic Recommended" + "\n" + "\n"
    end
    puts "Reviewer: #{@byline}"  + "\n" + "\n"
    puts "Synopsis: #{@short_summary}" + "\n" + "\n"
    puts "Read more here: #{@review_url}" +"\n" + "\n"
  end



end
