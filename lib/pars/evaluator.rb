class Evaluator
  attr_reader :keys
  def initialize(string)
    @keys = { }
    eval(string)
    local_variables.reject { |var| var == 'string' }.each do |meth|
      self.class.send(:attr_reader, meth.to_sym)
      instance_variable_set("@#{meth}", eval(meth))
    end
  end
  def method_missing(name, *args, &block)
    if block_given?
      @keys[name.to_sym] = block.call
    end
  end
end