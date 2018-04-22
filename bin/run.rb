require 'rubygems'
require 'bundler/setup'

require 'gosu'
require 'json'
require 'singleton'

require_relative '../app/button.rb'
require_relative '../app/cursor.rb'
require_relative '../app/game.rb'
require_relative '../app/input.rb'
require_relative '../app/tileset.rb'
require_relative '../app/path_finder.rb'
require_relative '../app/toolbar.rb'
require_relative '../app/window.rb'

require_relative '../app/enemies/enemy.rb'
require_relative '../app/enemies/basic_enemy.rb'

require_relative '../app/levels/level1.rb'

require_relative '../app/turrets/turret.rb'
require_relative '../app/turrets/basic_turret.rb'

Window.instance.show
