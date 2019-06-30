require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |scraped_courses| 
      new_course = Course.new
      new_course.title = scraped_courses.css("h2").text
      new_course.schedule = scraped_courses.css(".date").text
      new_course.description = scraped_courses.css("p").text
    end
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  

end

Scraper.new.get_page

