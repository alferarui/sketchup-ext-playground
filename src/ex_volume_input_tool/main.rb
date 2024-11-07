# Copyright 2024 Everybody
# Licensed under the MIT license

require 'sketchup.rb'
require 'extensions.rb'


puts "#{__FILE__} loaded"

module Examples
  class PointCaptureTool
    def initialize
      @points = []
      @mouse_point = nil
    end

    def activate
      Sketchup::set_status_text("Click to select the Anchor Point.", SB_PROMPT)
      reset_tool
    end

    def deactivate(view)
      view.invalidate
      Sketchup::set_status_text("")
    end

    def suspend(view)
      view.invalidate
    end

    def resume(view)
      view.invalidate
    end

    def reset_tool
      @points.clear
      Sketchup::set_status_text("Click to select the Anchor Point.", SB_PROMPT)
    end

    def onMouseMove(flags, x, y, view)
      if @points.size < 3
        point = view.inputpoint(x, y)
        view.tooltip = point.tooltip if point.valid?
        @mouse_point = point.position
        view.invalidate
      end
    end

    def onLButtonDown(flags, x, y, view)
      if @points.size < 3
        point = view.inputpoint(x, y)
        if point.valid?
          @points << point.position
          case @points.size
          when 1
            Sketchup::set_status_text("Anchor Point selected. Now, select the Opposite Corner.", SB_PROMPT)
          when 2
            Sketchup::set_status_text("Opposite Corner selected. Now, select the Height Point.", SB_PROMPT)
          when 3
            Sketchup::set_status_text("Height Point selected. Generating 3D shape...", SB_PROMPT)
            create_shape
          end
        end
      end
    end

    def draw(view)
      if @points.size > 0
        view.draw_points(@points, 10, 1, "red")
        view.draw_line(@points[0], @mouse_point) if @mouse_point
      end
    end

    # Define the bounding box for the drawing, so it is not clipped
    def getExtents
      return nil if @points.empty?

      bb = Geom::BoundingBox.new
      @points.each { |point| bb.add(point) }
      bb.add(@mouse_point) if @mouse_point
      bb
    end

    private

    def create_shape
      anchor_point, opposite_corner, height_point = @points

      # Use these points to create a 3D shape; as an example, let's create a simple box.
      model = Sketchup.active_model
      entities = model.active_entities

      width_vector = opposite_corner - anchor_point
      height_vector = height_point - anchor_point

      points = [
        anchor_point,
        anchor_point.offset(width_vector.x, 0, 0),
        opposite_corner,
        anchor_point.offset(0, width_vector.y, 0)
      ]

      base = entities.add_face(points)
      base.pushpull(height_vector.length)

      Sketchup::set_status_text("3D shape created successfully!", SB_PROMPT)
      reset_tool
    end
  end

  unless file_loaded?(__FILE__)
    menu = UI.menu("Plugins")
    menu.add_item("3D Shape Tool") {
      Sketchup.active_model.select_tool(PointCaptureTool.new)
    }
    file_loaded(__FILE__)
  end
end # module Examples
