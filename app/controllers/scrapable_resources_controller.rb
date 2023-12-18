class ScrapableResourcesController < ApplicationController
  def scrape
    url = params[:url]
    fields = params[:fields]
    result = Scrapable.scrape(url, fields)
    render json: result
  end
end
