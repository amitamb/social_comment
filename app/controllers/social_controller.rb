class SocialController < ApplicationController
  def new
    # render ccomment form
  end

  def create
    # accept postd comment data
    @status = params[:status]
    @image_url = params[:image_url]
  end

  def scrape
  
    @req_url = params[:url].strip
    
    if !( @req_url.start_with?("http") || @req_url.start_with?("https") )
      @req_url = "http://" + @req_url
    end
    
    a = Mechanize.new { |agent|
      agent.user_agent = "Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.0 Safari/535.1";
      agent.user_agent_alias = 'Linux Mozilla'
      #agent.user_agent_alias = Mechanize::AGENT_ALIASES['Linux Mozilla']
    }
    
    begin
      a.get(@req_url) do |page|        
        @rawdoc =  page.body
        @page = page
      end    
    rescue
      @rawdoc = "Page not found"
    end
    
    #@doc = Nokogiri::HTML(@rawdoc)
    
    #@doc.css("img").each do |img|
    #  puts img['src']
    #end
    
    base_uri = URI(@req_url.to_s)
    
    image_urls = @page.image_urls.map { |i| i.to_s }
    
    if image_urls.length == 0
      puts "No images Found"
      
      #try searching background images
      
      
    end

    puts image_urls

    @title = @page.title
    @desc = "TODO: Extract description from the document."

    # receive post data from ajax
    # make http call to posted url
    # parse response body with nokogiri (orr other) to extract image links
    #
    # combine images into array
    @images = image_urls.uniq
    
    # return array as JSON object
    render :json => { :images => @images, :title => @title , :description => @desc, :doc => @rawdoc }
  end

end
