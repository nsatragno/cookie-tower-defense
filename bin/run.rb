require 'rubygems'
require 'bundler/setup'

require 'gosu'
require 'json'
require 'singleton'

require_relative '../app/game.rb'
require_relative '../app/input.rb'
require_relative '../app/tileset.rb'
require_relative '../app/path_finder.rb'
require_relative '../app/window.rb'

require_relative '../app/levels/level1.rb'

Window.instance.show
