# frozen_string_literal: true

class Geo
  SRID = 4326

  def self.factory
    @factory ||= RGeo::Geographic.spherical_factory(srid: SRID)
  end

  def self.pairs_to_points(pairs)
    pairs.map { |pair| point(pair[0], pair[1]) }
  end

  # https://github.com/rgeo/rgeo/blob/main/doc/An-Introduction-to-Spatial-Programming-With-RGeo.md#22-coordinates
  def self.point(lon:, lat:)
    factory.point(lon, lat)
  end

  def self.line_string(points)
    factory.line_string(points)
  end

  def self.polygon(points)
    line = line_string(points)
    factory.polygon(line)
  end

  def self.to_wkt(feature)
    "srid=#{SRID};#{feature}"
  end

  def self.wkt_to_point(point)
    RGeo::WKRep::WKTParser.new(factory, support_ewkt: true).parse(point)
  end
end
