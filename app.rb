require 'bundler'
Bundler.require

require 'open-uri'

$:.unshift File.expand_path("./../lib", __FILE__)

require 'views/index'
require 'views/done'
require 'app/_styles'
require 'app/_put_slow'
require 'app/_ascii'
require 'app/cell'
require 'app/board'
require 'app/player'
require 'app/game'


Index.new.perform
