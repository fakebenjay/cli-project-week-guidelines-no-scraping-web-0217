class NYTimesReviewAPI

  attr_reader :url, :movies_data

  def initialize(url)
    @url = url
    @movies_data = []
  end

  def get_movies(url)
    movies = []
    result = JSON.parse(RestClient.get("https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=d53798cfd74849ef8afddd4882a4ebc0&query=the+force+awakens").body)
      result["results"].map do |movie|
        NYTimesReviewModel.new_from_api(movie)
      end
    end
  end
