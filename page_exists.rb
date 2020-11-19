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
Capybara.default_max_wait_time = 5
page = Capybara.page

visit '/CalendlyQA/full/KKPQLmV'

page.driver.browser.switch_to.frame 'result'

expect(page).to have_selector("input[placeholder='Enter a number to generate a tic tac toe board']")
expect(page).to have_button("start", text: "Play")

