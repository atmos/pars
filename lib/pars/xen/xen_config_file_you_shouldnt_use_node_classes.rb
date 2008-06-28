module XenConfigFileYouShouldntUse
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
end