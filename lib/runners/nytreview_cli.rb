require 'pry'

class ReviewCLI
  @@counter = 0

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
      if @@counter == 0
        kramer_dialogue
        second_input = get_user_input
        search(second_input)
      else
        puts "Using your touch-tone keypad, please enter the first three letters of the movie, now."
        gets.chomp
        puts "Why don't you just tell me the name of the movie you want to see???"
        second_input = get_user_input
        search(second_input)
      end
    elsif input.to_i == 2
      print_kramer
      merv_welcome(name="George Costanza")
      print_line
      ReviewCLI.trivia
    else
      "Please enter a valid input, or just subscribe to the Post already."
    end
      @@counter += 1
      self.run
  end

  def search(input)
    search_term = input.split.join("+")
    puts ""
    puts "#{input.split.map {|word| word.capitalize}.join(" ")} is playing at the Paragon 84th Street cinema in the main theater at 9:30pm."
    sleep(1)
    puts "It's also playing in theatre #2 at 9:30pm." + "\n" + "\n"
    @search_url = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&query=#{search_term}"
    ReviewAPI.new(@search_url).make_movies
  end

  def merv_welcome(name="George Costanza")
    print "Please enter your name: "
    name = gets.chomp
    if name == ""
      puts "Oh! Well, ladies and gentlemen! It's our good friend, George Costanza! What a surprise!"
    else
      puts "Oh! Well, ladies and gentlemen! It's our good friend, #{name}! What a surprise!"
    end
      sleep(1)
      puts "Welcome to The Merv Griffin Show!"
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
    100.times do
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

    def print_kramer
      puts "
                                              ``````
                                         ` ````.`````
                            ``.-` ``` `/-.-----.:.````
                          `  `````.`:``++-.+/sso/:-/://`
                         ...-.`.//..o-:/hyhdhhhmhhyhso::
                   ```..-+//+ssyyhyydshdmNdmmmNmmmdhss/.
                  ```.s+/ss/ydmmmmNNNNNNNNNNNNNNNNNmmh:-.`
                    `:sshmdmmmNNNNNNNNNNNNNNNNNNNNNNmdyo-`
                ```..oddNNNNNNNNNNNNNNNNNNNNNNNNNNNNmmmhy-``
               ``++::-hmNNNNNNNNNNNNNNNNNNNNNNNNNNNNNmmmdh/
                `ohy+omNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNmmmmNh-
                `+hNNNNNNNNNNNNNNNNNmNNmNNNNNNNNmmNmmmmmmmNmho`
                -ymmNNNNNNNNNNNNNmmmmmmmmdddddhhyhhdhysydmmmdo+`
               `/mmNNNNNNNNNNNmdhyyyyyyhyoo++/:::////:::/ymmy/o-
               `+mNNNNNNNNNmmhyso+++++//:-----.---..----::+hhyyo
               :mNNNNNNNNNmdyoo+++++//::-----......-.-----:/yddh.
               :mmNNNNNNNNmdsoo++++////:-----.....----------odmy
               `hmNNNNNNNNmdso++++///:::---------.-.-----:::-yd:
               `hmNNNNNNNNmdys++////::::::-----.-....:/+osys/+o`
                smmNNNNNNNNmhs++//////:::://::-.-.`.-::/++////:
                .ymmNNNNNNNmyo//+++++osyyyyys+-...`........`.-+
                 ymmNNNNNNmyo+++oosyhdddhysso++:....--///-:-.`/
                 -yyhdmmmmds+++oossso+++++::/ohy/:-..-oyo.:/.`-`
                 ./syyhdmmds+++++/++osohy:.-:syyo/:-..-:-.-.....
                 `/sshhymmds+++/:-:+++/:--.-/osoo+:--..````....`
                 `/oodNmdmdso++/:::::--------+o+so/---.........`
                  -o+hmmymdsooo++/::::--.-..-/ssso/-....`......`
                  `/osydhmmhssso++++/:--....+ysso+/-`..........
                   .//+ydmmmyyys++o++/:-...:yyoooo+-..........`
                    -+/+ydmmhsyso+oso/:-..-:+++o++/:.----.....
                    `+sssyhhhyssoosso/:----/+///-.--..-----...
                      .odyyyyysoooyyo:::::::+//:----.---....``
                      .dNdhhhhyo+oyys/:-::-:osss++//////-...`
                     .hNNNNmddhyooyhyo/:--://++/::::-----.-./o/:::.`
                   .smNNNNNNNdddhsshhyo/:://:://:::::--..-.:dddddhhy+-
                 `+mNNNNNNNNNNmdmdhhhyyso++///:-::-..------yddddddddhho-
               .+hNNNNNmmmmmmNNmddmmdhyyhso////::-....---.:shhddhhddddhh/
             .odmNNNNNNmmmmmmmmmmmhyhdddddhs+///:-------.---+hhhhhhhdddhd/
           -sdmmmNmmmNNmmmmmddmmmmmdsosyhddhyso++////:-..:/:-/hhhhhhhddhhh.
         -smmmdmmmmmdmmmmmmmmddmmdmmmho//+shsss+///:---../+//::yhhhhhddyhd/
       -ymmmddddddmmdmmmNNNmmmddmdddmmd+:::/s//o+:-----..+++//::dhhhhdddyh+
    `/hmmmmdddddddddddmmmNmmmmdddddddddds/--:+::/+::--..:yhdho/:+ddhyhhhhh+
  .odmmmmdddddddddddddddmdmmmmmdddddhhhhhds:-:/:::---.`.sdmdddo::+hdhyhhhho
:ymmmmddddddddhhhddddddddddmNmmmdddddhhhdhhho----..:/-`.sddyyhs/:--ohhyyhh+

      "
    end

    def kramer_dialogue
      print_kramer
      sleep(1)
      puts "Hello!"
      sleep(1)
      puts "And welcome to MovieFone!"
      sleep(1)
      puts "Brought to you by The New York Times"
      sleep(1)
      puts "and Hot 97."
      sleep(1)
      puts "Coming to theatres this Friday..."
      sleep(1)
      puts "Kevin Bacon."
      sleep(1)
      puts "Susan Sarandon."
      sleep(1)
      puts "***You've got to get me over that mountain!***"
      sleep(1)
      puts "***Now***"
      sleep(1)
      puts "*** *bang* *bang* ***"
      sleep(1)
      puts "***AAAAHHHHHHHHHHH***"
      sleep(1)
      puts "There is no place higher than..."
      sleep(1)
      puts "...Mountain High."
      sleep(1)
      puts "Rated R."
      sleep(1)
      puts "If you know the name of the movie you'd like to see..."
      sleep(1)
      puts "Using your touch-tone keypad, please enter the first three letters of the movie, now."
      input = gets.chomp.downcase
      if input == "kramer?"
        sleep(1)
        puts "Elaine?"
        exit
      else
        sleep(1)
        puts "......."
        sleep(1)
        puts "You've selected..."
        sleep(1)
        puts "......."
        sleep(1)
        puts "Agent Zero?"
        sleep(1)
        puts "If that's correct, press 1."
        input = gets.chomp
        if input == "1" || input == "one"
          search('X-Men Origins: Wolverine')
          self.run
        else
          sleep(1)
          puts "......."
          sleep(1)
          puts "Ah, you've selected..."
          sleep(1)
          puts "......."
          sleep(1)
          puts "Brown-Eyed Girl?"
          sleep(1)
          puts "If this is correct, press 1."
          input = gets.chomp
          if input == "1" || input == "one"
            search('The Big Chill')
            self.run
          else
            sleep(1)
            puts "......."
            sleep(1)
            puts "......."
            sleep(1)
            puts "......."
            sleep(1)
            puts "Why don't you just tell me the name of the movie you want to see???"
            sleep(1)
            puts "(you can also narrow your search by typing between 'single quotes'.)"
          end
        end
      end
    end

end
