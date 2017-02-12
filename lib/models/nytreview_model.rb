class Model

  attr_accessor :display_title, :publication_date, :rating, :critics_pick, :byline, :short_summary, :review_url

  def initialize(display_title,publication_date,rating,critics_pick,byline,short_summary,review_url,number=0)
    @display_title = display_title
    @publication_date = publication_date
    @rating = rating
    @critics_pick = critics_pick
    @byline = byline
    @short_summary = short_summary
    @review_url = review_url
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



end
