class LinksController < ApplicationController
  require 'httparty'
  require 'nokogiri'
  require 'pry'
  require 'chronic'

  def new
    @link = Link.new
  end

  def create
    link_param = params[:link]
    link_url = link_param[:url]
    @link = Link.new(link_params)
    Scraper.get_scraped_data(link_url)
    if @link.save
      redirect_to links_path
    else
      render 'new'
    end
  end

  def index
    @scraper_data = Scraper.all.uniq
  end

  private
    def link_params
      params.require(:link).permit(:url)
    end
end
