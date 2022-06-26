class Route
  attr_accessor :name

  def initialize(name)
    @name = name
    @station_list = []
  end

  def add_station(station, index=nil)
    raise StandardError.new "Type error (given #{station.class} expected Carriage)" unless station.class == Station
    return 'index is too large' if !index.nil? && index > station_list.size
    return nil if station_list.include?(station)
    station_list.insert(index.nil? ? station_list.size : index, station)
    nil
  end

  def remove_station(station)
    station_list.delete(station) and nil
  end

  def stations
    station_list
  end

  private

  attr_accessor :station_list
end
