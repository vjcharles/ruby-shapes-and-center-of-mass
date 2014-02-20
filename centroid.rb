#!/usr/local/bin/ruby

# centroid, and center of mass in ruby
# equations listed at:
# http://local.wasp.uwa.edu.au/~pbourke/geometry/polyarea/
# java code by: Christopher Fuhrman (christopher.fuhrman@gmail.com) :
# http://local.wasp.uwa.edu.au/~pbourke/geometry/polyarea/PolygonUtilities.java
# the last point (same as the first), does not need to be included in the 
# points array argument

class Poly
  # area
  def self.area(poly_points)
    j = poly_points.length
    n = j
    area = 0
    poly_points.each_with_index do |p, i|
      j = (i + 1) % n
      area += p.x * poly_points[j].y
      area -= poly_points[j].x * p.y
    end
    area /= 2.0
    return area
  end
  
  # centroid / center of mass
  def self.centroid(poly_points)
    cx = 0.0
    cy = 0.0
    area = area(poly_points)
    centroid = Point.new
    j = poly_points.length
    n = j
    factor = 0.0
    poly_points.each_with_index() do |p, i|
      j = (i + 1) % n
      factor = p.x * poly_points[j].y - poly_points[j].x * p.y
      cx += (p.x + poly_points[j].x) * factor
      cy += (p.y + poly_points[j].y) * factor
    end
    
    area *= 6.0
    factor = 1 / area
    cx *= factor
    cy *= factor
    centroid.set_point cx, cy
  end
end

# basic point
class Point 
  def initialize(x=0, y=0)
    @x = x
    @y = y
  end
  attr_accessor :x, :y
  
  def to_s
    # round
    x = round_to(@x, 2)
    y = round_to(@y, 2)
    " (" + x.to_s + "," + y.to_s + ") "
  end
  
  def set_point x, y
    @x = x
    @y = y
    return self
  end
end

def round_to(val, x)
  (val * 10**x).round.to_f / 10**x
end

##not in code.vc.com
if __FILE__ == $0
  #last point same as first needed...to denote closed polygon...
  square = [Point.new(0,0), Point.new(2,0), Point.new(2,2), Point.new(0,2), Point.new(0,0)]
  puts "points:   " + square.to_s
  puts "area:     " + Poly.area(square).to_s
  puts "centroid: " + Poly.centroid(square).to_s

  puts 

  square = [Point.new(0,0), Point.new(1,0), Point.new(1,1), Point.new(0,1)]
  puts "points:   " + square.to_s
  puts "area:     " + Poly.area(square).to_s
  puts "centroid: " + Poly.centroid(square).to_s


  puts 

  square = [Point.new(0,0), Point.new(1,0), Point.new(0,1)]
  puts "points:   " + square.to_s
  puts "area:     " + Poly.area(square).to_s
  puts "centroid: " + Poly.centroid(square).to_s
  
end
