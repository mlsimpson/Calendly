#!/usr/bin/env ruby

require 'rspec'
require 'capybara'
require 'capybara/dsl'

include RSpec::Matchers
include DSL
# Suppress global scope warning for Capybara::DSL
include Capybara::DSL

Capybara.current_driver = :selenium
Capybara.run_server = false
Capybara.app_host = 'https://codepen.io'
Capybara.default_max_wait_time = 2
page = Capybara.page

gridsize = 3

visit '/CalendlyQA/full/KKPQLmV'

page.driver.browser.switch_to.frame 'result'

page.fill_in('number', with: gridsize)

page.click_on('Play')

# First player is X, this will fill the first row with X's
(0..gridsize).each do |i|
  page.find_by_id("#{i}").click()
  break if (i+gridsize) == ((gridsize * 2) - 1)
  page.find_by_id("#{i+gridsize}").click()
end

# First, make sure winning condition has been met
expect(page).to have_content("Congratulations")

# Player x should win, but the modal is incorrect
expect(page).to have_content("player X")
