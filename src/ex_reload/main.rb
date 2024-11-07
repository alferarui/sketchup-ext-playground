# Copyright 2024 Everybody
# Licensed under the MIT license

require 'sketchup.rb'
require 'extensions.rb'


puts "#{__FILE__} loaded"

module Examples
  module HelloCube

    def self.reload_extensions
      Examples.reload
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Extensions')
      menu.add_item('Reload') {
        self.reload_extensions
      }
      file_loaded(__FILE__)
    end

  end # module HelloCube
end # module Examples
