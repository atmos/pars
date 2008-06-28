module XenConfigFileYouShouldntUse
  class ConfigFile < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      elements.each do |e|
        begin
          pp e.eval(env)
          # result = e.eval(env)
          # if result.kind_of?(String)
          #   pp result if env.nil?
          #   env[result] = nil
          # else
          #   env.merge(result)
          # end
        rescue => exception
          # pp e
          puts exception.backtrace
          pp "ZOMFG #{exception.message}"
        end
      end
      env
    end
  end
  
  class AssignmentNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[lhs.text_value.to_sym] = rhs.eval(env)
    end
  end
  
  class CommentNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end
  
  class VariableNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      value.eval(env)
    end
  end

  class StringLiteralNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      value.text_value
    end
  end
  
  class NumberNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value.to_i
    end
  end
end