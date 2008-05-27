module KeepAlivedConfigFileYouShouldntUse
  class ConfigFile < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      elements.each do |e|
        begin
          result = e.eval(env) rescue nil
          result.kind_of?(String) ? env[result] = nil : env.merge(result)
        rescue => exception
          pp e
        end
      end
      env
    end
  end
  
  class AssignmentNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value.to_sym] = varvalue.eval(env)
      env
    end
  end
  
  class VariableNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end
  
  class NumberNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value.to_i
    end
  end
  
  class ScopedBlockNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value.to_sym] = block_contents.eval({})
      env
    end
  end
end