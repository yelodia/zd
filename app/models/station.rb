class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @train_list = []
  end

  def train_arrived(train)
    raise StandardError.new "Type error (given #{train.class} expected Train)" unless train.class == Train
    return false unless train.current_station == self
    return true if train_list.include?(train)
    train_list << train
    true
  end

  def train_left(train)
    raise StandardError.new "Type error (given #{train.class} expected Train)" unless train.class == Train
    return false if train.current_station == self
    train_list.delete(train)
    true
  end

  def trains
    train_list
  end

  private

  attr_writer :name
  attr_accessor :train_list
end
