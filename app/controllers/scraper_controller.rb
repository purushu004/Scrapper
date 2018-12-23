class ScraperController < ApplicationController

  def get_7days_data
    @seven_day_data = Scraper.all.where(date: (Time.now - 7.day)..Time.now)

    respond_to do |format|
      format.html
      format.csv { send_data @seven_day_data.to_csv }
    end
  end

  def get_30days_data
    @thirty_day_data = Scraper.all.where(date: (Time.now - 30.day)..Time.now)

    respond_to do |format|
      format.html
      format.csv { send_data @thirty_day_data .to_csv }
    end
  end
end


