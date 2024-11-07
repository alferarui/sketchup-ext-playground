# Copyright 2024 Everybody
# Licensed under the MIT license

require 'sketchup.rb'
require 'extensions.rb'


puts "#{__FILE__} loaded"

module Examples
  module HelloCube

    def self.create_stair_2
      model = Sketchup.active_model
      model.start_operation('Create Stair', true)
      group = model.active_entities.add_group
      entities = group.entities
      points = []
      (0..15).each{ |i|
        points.push(
          Geom::Point3d.new(      i*30.cm,   0,   i*15.cm),
          Geom::Point3d.new(  (1+i)*30.cm,   0,   i*15.cm)
        )
      }
      points.push(
        Geom::Point3d.new(  (2+15)*30.cm,     0  ,   (15)*15.cm),
        Geom::Point3d.new(  (2+15)*30.cm,     0  ,   (14)*15.cm),
        Geom::Point3d.new(  (1+15)*30.cm,     0  ,   (14)*15.cm),
        Geom::Point3d.new(  (1+15)*30.cm,     0  ,   (13)*15.cm),
        Geom::Point3d.new(    (15)*30.cm,     0  ,   (13)*15.cm),
        Geom::Point3d.new(         60.cm,     0  ,            0),
        Geom::Point3d.new(         60.cm,     0  ,       -15.cm),
        Geom::Point3d.new(             0,     0  ,       -15.cm),
        Geom::Point3d.new(             0,     0  ,            0),
      )
      face = entities.add_face(points)
      face.pushpull(1.m)

      model.commit_operation
      # UI.messagebox('Finished')
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Extensions')
      menu.add_item('Stair 2') {
        self.create_stair_2
      }
      file_loaded(__FILE__)
    end

  end # module HelloCube
end # module Examples
