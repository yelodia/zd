class Carriage
  attr_reader :number, :type, :train

  TYPES = %w[pass cargo].freeze

  def initialize(type, number)
    @type = TYPES.include?(type) ? type : 'cargo'
    @number = number
    @train = nil
  end

  def set_train(train_obj)
    raise StandardError.new "Type error (given #{train_obj.class} expected Train)" unless train_obj.class == Train
    return nil if train_obj === train
    err = train_obj.add_carriage(self)
    return err unless err.nil?
    @train = train_obj and nil
  end

  def unset_train
    return nil if train.nil?
    train.remove_carriage(self)
    @train = nil and nil
  end

  def is_busy?
    !train.nil?
  end

  private

  attr_writer :number, :type, :train
end
