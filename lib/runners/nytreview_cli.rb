class ReviewCLI
  def call
    puts "Check it, dis is da NY Times Film Review Finder" +  "\n" + "\n"
    sleep(1)
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    puts "Use your keyboard to type a film you've been dying to see, or type 'help' if you need some help."
    puts "You can also narrow your search by typing between 'single quotes'." + "\n" + "\n"
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit
    else
      search(input)
    end
    run
  end

  def search(input)
    search_term = input.split.join("+")
    puts "I am now scanning the world wide web for #{input}. Respec." +  "\n" + "\n"
    @search_url = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&query=#{search_term}"
    ReviewAPI.new(@search_url).make_movies
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for a year's worth of Critics' Picks"
  end

  def open_url
    ReviewAPI.new(@search_url).launch_url
  end
end
