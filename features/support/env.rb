require 'watir-webdriver'
require 'rspec'
require 'page_helper'
require 'require_all'
require 'saucelabs'
require 'nokogiri'
require 'active_support/core_ext'

require './lib/page_helper'
require './lib/data_helper'

require_all './lib/pages'


World PageHelper
World DataHelper




