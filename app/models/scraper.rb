
require 'httparty'
require 'nokogiri'
require 'pry'
require 'chronic'

class Scraper < ApplicationRecord
  def self.get_scraped_data link

    links = []
    links << link

    links.each do |url|
      html_content = get_dom_of_link(url)
      sleep(10)
      if (html_content)
        total_pages = html_content.css('div .homes').text

        max_page_number = total_pages.split(/[^\d]/).max.to_i

        pagination = (max_page_number.to_f/20.to_f).ceil

        for page in 1..pagination
          inner_link = url + "/page-" + page.to_s
          inner_html_dom = get_dom_of_link(inner_link);
          if (inner_html_dom)
            page_min = (page - 1) * 20
            page_max = 20 * page

            if page != pagination
              for j in page_min...page_max
                if (inner_html_dom.css("#MapHomeCard_#{j}"))
                  data = inner_html_dom.css("#MapHomeCard_#{j}").css(".HomeCard").text
                  fetched_date = inner_html_dom.css("#MapHomeCard_#{j}").search("div.topleft").text
                  address = inner_html_dom.css("#MapHomeCard_#{j}").search("div.addressDisplay").text
                  price = inner_html_dom.css("#MapHomeCard_#{j}").search("span.homecardV2Price").text
                  home_details = inner_html_dom.css("#MapHomeCard_#{j}").search("div.HomeStatsV2").text
                  sold_date = Chronic.parse(fetched_date)
                  sleep(10)
                  if Scraper.where(address:address).first == nil
                    self.find_or_create_by(date: sold_date, address: address, price: price, home_details: home_details)
                  end
                end
              end
            elsif page == pagination
              start = (page - 1) * 20
              x = max_page_number % 20 + start
              for j in start...x
                if (inner_html_dom.css("#MapHomeCard_#{j}"))
                  data = inner_html_dom.css("#MapHomeCard_#{j}").css(".HomeCard").text
                  fetched_date = inner_html_dom.css("#MapHomeCard_#{j}").search("div.topleft").text
                  address = inner_html_dom.css("#MapHomeCard_#{j}").search("div.addressDisplay").text
                  price = inner_html_dom.css("#MapHomeCard_#{j}").search("span.homecardV2Price").text
                  home_details = inner_html_dom.css("#MapHomeCard_#{j}").search("div.HomeStatsV2").text
                  sold_date = Chronic.parse(fetched_date)
                  sleep(10)
                  if Scraper.where(address:address).first == nil
                    self.create(date: sold_date, address: address, price: price, home_details: home_details)
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  def self.get_dom_of_link(url)
    doc = HTTParty.get(url)
    Nokogiri::HTML(doc)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names

      all.each do |result|
        csv << result.attributes.values_at(*column_names)
      end
    end
  end
end
