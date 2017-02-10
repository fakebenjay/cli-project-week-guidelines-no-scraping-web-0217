class NYTimesReviewModel

  attr_reader :display_title, :rating, :critics_pick, :byline, :director, :short_summary, :review_url

  def initialize(display_title,rating,critics_pick,byline,director,short_summary,review_url)
    @display_title = display_title
    @rating = rating
    @critics_pick = critics_pick
    @byline = byline
    @director = director
    @short_summary = short_summary
    @review_url = review_url
  end

  def new_from_api(movie)
    @display_title = NYTimesReviewAPI.get_movies(["display_title"])

end
