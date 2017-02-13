require 'timeout'

class ReviewAPI

  attr_reader :url, :movies_data

  def initialize(search_url)
    @search_url = search_url
    @movies_data = JSON.parse(RestClient.get(search_url).body)
  end

  def movies_list
    result = @movies_data
    puts "\n"
    result["results"].collect.with_index do |movie,index|
      puts "#{index + 1}. #{movie["display_title"]} (#{movie["publication_date"].split("-")[0]})"
    end
     puts "\n"
     puts "Please enter the number associated with the correct movie."
     puts "Or to narrow your search to a specific title, please retype your search query between 'single quotes'."
  end

  def movie_model
    result = @movies_data
    user_input = gets.chomp
    user_input_int = user_input.to_i
    user_input_int -= 1
    if user_input_int.between?(1, 20)
      Model.new(result["results"][user_input_int]["display_title"],result["results"][user_input_int]["publication_date"],result["results"][user_input_int]["mpaa_rating"],result["results"][user_input_int]["critics_pick"],result["results"][user_input_int]["byline"],result["results"][user_input_int]["summary_short"],result["results"][user_input_int]["link"]["url"],result["results"][user_input_int]["opening_date"]).display_information
    elsif user_input == "exit"
      exit
    else
      ReviewCLI.new.search(user_input)
    end
  end

  def make_movies
    user_input = 0
    result = @movies_data
    if result["results"].count == 1
      Model.new(result["results"][0]["display_title"],result["results"][0]["publication_date"],result["results"][0]["mpaa_rating"],result["results"][0]["critics_pick"],result["results"][0]["byline"],result["results"][0]["summary_short"],result["results"][0]["link"]["url"], result["results"][0]["opening_date"]).display_information
    elsif result["results"].count > 1 && !result["has_more"]
      puts "We found a few movies that matched your search." + "\n"
      movies_list
      movie_model
    elsif result["has_more"]
      puts "We found a lot of movies that matched your search." + "\n"
      movies_list
      movie_model
    else
      puts "We could not find any matches, please try again"
    end
  end

  def trivia
    result = JSON.parse(RestClient.get(@search_url).body)
      until Model.trivia_hash.length == 4 && !Model.trivia_hash.values.include?(nil) && Model.trivia_hash.values.uniq.length == 1
       search_index = rand(0..19)
      Model.new(result["results"][search_index]["display_title"],result["results"][search_index]["publication_date"],result["results"][search_index]["mpaa_rating"],result["results"][search_index]["critics_pick"],result["results"][search_index]["byline"],result["results"][search_index]["summary_short"],result["results"][search_index]["link"]["url"], result["results"][search_index]["opening_date"]).populating_trivia_hash
      Timeout::timeout(3) do
        puts "timeout"
        self
      end
      end
    Model.play_trivia
  end

end
