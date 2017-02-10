class NYTimesReviewCLI
  def call
    puts "TKTKTKTKTKTK"
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    print "Please enter a year: "
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit
    elsif
      search(input)
    #else
    end
    run
  end

  def search(input)
    search_term = input.split.join("+")
    puts "Your search term was #{input}, I am searching..."
    url = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&query=#{search_term}"
    movies = NYTimesReviewAPI.new(url).get_movies
    movies.each do |movie|
      puts movie.example
    end
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for a year's worth of Critics' Picks"
  end

end
