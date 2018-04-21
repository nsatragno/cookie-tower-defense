require 'rubygems'
require 'bundler/setup'

require 'gosu'
require 'json'
require 'singleton'

require_relative '../app/game.rb'
require_relative '../app/input.rb'
require_relative '../app/window.rb'

Window.instance.show
