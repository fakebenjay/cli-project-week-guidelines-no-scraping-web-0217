class NYTimesReviewCLI
  def call
    puts "Check it, dis is a hip new app built around NY Times Film Reviews" +  "\n" + "\n"
    sleep(1)
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    print "We got more than one option for you, so listen up."
    sleep(1)
    print "\n \nHit the numero uno - 1 - key to search the NY Times for a specific movie review, or dos - 2 - to play our wicked Guess That Year app. If you's is confused, please scream for help, but also be sure to type it in. Exit will take you out of this app.\n \n"
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit
    elsif input.to_i == 1
      print "\nGreat. So you want to get all educated like. Use the keys on your keyboard to type a film you've been dying to see" "\n" + "\n"
      second_input = get_user_input
      search(second_input)
    else input.to_i == 2
      print "\n \nBooyakasha, let's go ahead and test that knowledge now, shall we?"
      trivia
    end
    run
  end

  def search(second_input)
    search_term = second_input.split.join("+")
    puts "\nI am now scanning the world wide web for #{second_input.split.map {|word| word.capitalize}.join(" ")}. Respec. \n" + "\n"
    search_url = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&query=#{search_term}"
    ReviewAPI.new(search_url).search
  end

  def trivia
    trivia_search_url = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&critics-pick=Y&offset=#{rand(2600)}"
    ReviewAPI.new(trivia_search_url).trivia
  end


  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for a year's worth of Critics' Picks"
  end
end
