module KeepAlivedConfigFileYouShouldntUse
  class ConfigFile < Treetop::Runtime::SyntaxNode
    def eval(env={})
      elements.each do |e|
        result = e.eval(env)
        result.kind_of?(String) ? env[result] = nil : env.merge(result)
      end
      env
    end
  end
  
  class AssignmentNode < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value.to_sym] = varvalue.eval(env)
      env
    end
  end
  class VariableNode < Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end
  class NumberNode < Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value.to_i
    end
  end
  class GlobalDefNode < Treetop::Runtime::SyntaxNode
    def eval(env={})
      pp env
    end
  end
end