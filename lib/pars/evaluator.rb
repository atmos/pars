class Evaluator
  def initialize(string)
    eval(string)
    local_variables.reject { |var| var == 'string' }.each do |meth|
      self.class.send(:attr_reader, meth.to_sym)
      instance_variable_set("@#{meth}", eval(meth))
    end
  end
end