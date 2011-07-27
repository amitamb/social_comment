class SocialController < ApplicationController
  def new
    # render ccomment form
  end

  def create
    # accept postd comment data
  end

  def scrape
  
    @req_url = params[:url].strip
    
    a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
    
    begin
      a.get(@req_url) do |page|
        @rawdoc =  page.body 
      end    
    rescue
      @rawdoc = "Page not found"
    end
    
    @doc = Nokogiri::HTML(@rawdoc)
    
    base_uri = URI(@req_url.to_s)
    
    image_urls = []
    
    @doc.css("img").each do |img|
      img_url = (base_uri + img['src']).to_s
      # do some preliminary filtering if req
      image_urls << img_url
    end
  
    # receive post data from ajax
    # make http call to posted url
    # parse response body with nokogiri (orr other) to extract image links
    #
    # combine images into array
    @images = image_urls.uniq!
    # return array as JSON object
    render :json => @images
  end

end
