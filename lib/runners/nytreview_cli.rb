class ReviewCLI
  def call
    print_nyt_logo
    sleep(0.5)
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    puts "To search the NY Times archive for a movie review, please enter '1'."
    puts "If you'd like to play 'Guess That Year', please enter '2'."
    puts "For assistance, enter 'help'."
    puts "Typing 'exit' will take you out of this app.\n \n"
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit
    elsif input.to_i == 1
      puts ""
      puts "Use your keyboard to type a film you've been dying to see, or type a director's name to view his/her oeuvre,"
      puts "or type 'help' if you need some help."
      puts "You can also narrow your search by typing between 'single quotes'." + "\n" + "\n"
      puts ""
      second_input = get_user_input
      search(second_input)
    elsif input.to_i == 2
      print "\nBooyakasha, let's go ahead and test that knowledge now, shall we?"
      print_line
      ReviewCLI.trivia
    else
      "Please enter a valid input"
    end
    self.run
  end

  def search(input)
    search_term = input.split.join("+")
    puts ""
    puts "I am now scanning the world wide web for #{input.split.map {|word| word.capitalize}.join(" ")}. Respec." +  "\n" + "\n"
    @search_url = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&query=#{search_term}"
    ReviewAPI.new(@search_url).make_movies
  end

  def self.trivia
    trivia_search_url = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&critics-pick=Y&offset=#{rand(2600)}"
    ReviewAPI.new(trivia_search_url).trivia
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
  end

  def print_line
    puts ""
    139.times do
      print "-"
    end
  end

  def print_nyt_logo
    puts "

                  `:+@@@@#':.          @'`
                :@#@@@@@@@@@##@@#;,..,+@@#@
               @@@@######@@@@@@@@@@##@@@@@@
              .#@@:`   `.:'#@@##@@@@@@@@@;
               ,@,     `:,     .:+@@@+:,
                    ,#@`    .;#`    `
                  +@@` .;@@##@@`   ``
                +#@@:.  ,@@@@@#    ``
               @@@@,    :@@@@@#   ;@@+`
              @@@@#`    ;@@@@@#  .@##@'.
             ,@@@@@,    '@@@@@#    ..
             ;@@@@@@    +@@@@#@    ``
             `#@@@@@#   +#@',      ``    +
              '@@@@@@@:;.          `` `+##
               ;#@@@@@@@:          `,@#@@
                `@#@@@@@@#@@+;:;;#@@@@#+
                  `'@#@@@@@@@@@@@@@#@+
                      ,'@@@@@@@@@+:`

        NYTimes.com: all the code that's fit to puts"
        puts ""
      end

end
