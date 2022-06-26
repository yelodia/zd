class Train
  attr_accessor :max, :station
  attr_reader :number, :type, :route

  TYPES = %w[pass cargo].freeze

  def initialize(number, type, max)
    @number = number
    @type = TYPES.include?(type) ? type : 'cargo'
    @max = max
    @carriage_list = []
    @route = nil
    @station = nil
  end

  def add_carriage(carriage)
    raise StandardError.new "Type error (given #{carriage.class} expected Carriage)" unless carriage.class == Carriage
    return nil if carriage_list.include?(carriage)
    return 'max is exceeded' if carriage_list.size == max
    return 'types do not match' if carriage.type != type
    return 'carriage is busy' if carriage.is_busy?
    carriage_list << carriage
    carriage.set_train(self)
  end

  def remove_carriage(carriage)
    return nil unless carriage_list.include?(carriage)
    carriage_list.delete(carriage)
    carriage.unset_train
  end

  def carriages
    carriage_list
  end

  def set_route(route)
    raise StandardError.new "Type error (given #{route.class} expected Carriage)" unless route.class == Route
    return 'route is empty' if route.stations.empty?
    change_station do
      @route = route
      @station = route.stations[0]
    end
  end

  def move_next
    return 'route is undefined' if route.nil?
    return 'route is finished' if next_station.nil?
    change_station do
      @station = next_station
    end
  end

  def current_station
    station
  end

  def next_station
    return nil if route.nil?
    current = route.stations.index(current_station) || -1
    route.stations[current+1]
  end

  def prev_station
    return nil if route.nil?
    current = route.stations.index(current_station) || 0
    current == 0 ? nil : route.stations[current-1]
  end

  private

  attr_writer :number, :type, :route
  attr_accessor :carriage_list

  def change_station(&block)
    st = current_station
    yield
    st.train_left(self) if st
    current_station.train_arrived(self)
    nil
  end
end
