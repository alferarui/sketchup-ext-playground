# Copyright 2016-2022 Trimble Inc
# Licensed under the MIT license

require 'sketchup.rb'
require 'extensions.rb'

module Examples # TODO: Change module name to fit the project.
  module HelloCube

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Hello Cube', 'ex_hello_cube/main')
      ex.description = 'SketchUp Ruby API example creating a cube.'
      ex.version     = '1.0.0'
      ex.copyright   = 'Trimble Inc © 2016-2022'
      ex.creator     = 'SketchUp'
      Sketchup.register_extension(ex, true)

      puts "Hello Cube Extension Loaded"

      ex = SketchupExtension.new('Ex Main', 'ex_stair_1/main')
      ex.description = 'Creating a stair 01'
      ex.version     = '1.0.0'
      ex.copyright   = 'Me Inc © 2016-2022'
      ex.creator     = 'Me'
      Sketchup.register_extension(ex, true)

      puts "Stair 01 Extension Loaded"

      ex = SketchupExtension.new('Ex Stair 2', 'ex_stair_2/main')
      ex.description = 'Creating a stair 02'
      ex.version     = '1.0.0'
      ex.copyright   = 'Me Inc © 2016-2022'
      ex.creator     = 'Me'
      Sketchup.register_extension(ex, true)

      puts "Stair 01 Extension Loaded"

      ex = SketchupExtension.new('Ex Reload', 'ex_reload/main')
      ex.description = 'Reloading extensions'
      ex.version     = '1.0.0'
      ex.copyright   = 'Me Inc © 2016-2022'
      ex.creator     = 'Me'
      Sketchup.register_extension(ex, true)

      puts "Reload Extension Loaded"


      extension = SketchupExtension.new('3D Shape Tool', 'ex_volume_input_tool/main')
      extension.description = 'Tool to capture three points: anchor, opposite corner, and height.'
      extension.version     = '1.0.0'
      ex.copyright          = 'Me Inc © 2016-2022'
      ex.creator            = 'Me'

      Sketchup.register_extension(extension, true)

      file_loaded(__FILE__)

    end

  end # module HelloCube
  # Reload extension by running this method from the Ruby Console:
  #   Example::HelloWorld.reload
  def self.reload
    original_verbose = $VERBOSE
    $VERBOSE = nil
    pattern = File.join(__dir__, '**/*.rb')
    Dir.glob(pattern).each { |file|
      # Cannot use `Sketchup.load` because its an alias for `Sketchup.require`.
      load file
    }.size
    puts "Examples Re-loaded"
  ensure
    $VERBOSE = original_verbose
  end
end # module Examples

puts "#{__FILE__} loaded"
