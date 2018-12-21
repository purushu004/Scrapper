class ScraperController < ApplicationController
  def home
  end

  def scraper
    Scraper.get_scraped_data
  end

  def get_7days_data
    @seven_day_data = Scraper.all.where(date: (Time.now - 7.day)..Time.now)
  end

  def get_30days_data
    @thirty_day_data = Scraper.all.where(date: (Time.now - 30.day)..Time.now)
  end

end
