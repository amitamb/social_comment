class SocialController < ApplicationController
  def new
    # render ccomment form
  end

  def create
    # accept postd comment data
  end

  def scrape
    # receive post data from ajax
    # make http call to posted url
    # parse response body with nokogiri (orr other) to extract image links
    #
    # combine images into array
    @images = []
    # return array as JSON object
    render :json => @images
  end

end
