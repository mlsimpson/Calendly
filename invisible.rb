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
Capybara.default_max_wait_time = 10
page = Capybara.page

visit '/CalendlyQA/full/KKPQLmV'

page.driver.browser.switch_to.frame 'result'

page.fill_in('number', with: '1')

page.click_on('Play')

within('#table') do
  expect(all('tr').count).to_not eq(1)
end
