module KeepAlivedConfigFileYouShouldntUse
  class AssignmentOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value] = varvalue.eval(env)
      env
    end
  end
  class GlobalDefNode < Treetop::Runtime::SyntaxNode
    def eval(env={})
      pp env
    end
  end
end