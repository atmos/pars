module LvmBackup
  class AssignmentOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      # pp env
      # pp self
      env[varname.text_value] = varvalue.text_value
      env
    end
  end
  class BlockOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      # pp env
      # pp self
      env["#{name.text_value}"] = block_contents.eval({})
      env
    end
  end
  class StringLiteral < Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
      # operator.apply(name.eval(env), block_contents.eval(env))
    end
  end
end