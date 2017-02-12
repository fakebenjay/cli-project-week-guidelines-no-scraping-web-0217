class ReviewAPI

  attr_reader :url, :movies_data

  def initialize(search_url)
    @search_url = search_url
    @movies_data = JSON.parse(RestClient.get(search_url).body)
  end

  def make_movies
    user_input = 0
    result = @movies_data

    if result["results"].count == 1
      Model.new(result["results"][0]["display_title"],result["results"][0]["publication_date"],result["results"][0]["mpaa_rating"],result["results"][0]["critics_pick"],result["results"][0]["byline"],result["results"][0]["summary_short"],result["results"][0]["link"]["url"]).display_information
    elsif result["results"].count > 1 && !result["has_more"]
      puts "We found a few movies that matched your search."
      puts "\n"
      result["results"].each_with_index do |movie,index|
        puts "#{index + 1}. #{movie["display_title"]} (#{movie["publication_date"].split("-")[0]})"
      end

      puts "\n"
      puts "Please enter the number associated with the correct movie"
      user_input = gets.chomp.to_i
      user_input -= 1
      Model.new(result["results"][user_input]["display_title"],result["results"][user_input]["publication_date"],result["results"][user_input]["mpaa_rating"],result["results"][user_input]["critics_pick"],result["results"][user_input]["byline"],result["results"][user_input]["summary_short"],result["results"][user_input]["link"]["url"]).display_information
    elsif result["has_more"]
      puts "We found a lot of movies that matched your search."
      puts "\n"
      result["results"].each_with_index do |movie,index|
        puts "#{index + 1}. #{movie["display_title"]} (#{movie["publication_date"].split("-")[0]})"
      end
      puts "\n"
      puts "Please enter the number associated with the correct movie."
      puts "Or to narrow your search to a specific title, please retype your search query between 'single quotes'."
      user_input = gets.chomp

      if user_input.to_i.between?(1, 20)
        user_input -= 1
        Model.new(result["results"][user_input]["display_title"],result["results"][user_input]["publication_date"],result["results"][user_input]["mpaa_rating"],result["results"][user_input]["critics_pick"],result["results"][user_input]["byline"],result["results"][user_input]["summary_short"],result["results"][user_input]["link"]["url"]).display_information
      elsif user_input == "exit"
        exit
      else
        ReviewCLI.new.search(user_input)
      end
    else
      puts "We could not find any matches, please try again"
    end
  end

  #def launch_url
  #  Launchy::Browser.run("#{result["results"][0]["link"]["url"]}")
  #end

end
