module LvmBackup
  class AssignmentOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value] = varvalue.text_value
      env
      
    end
  end

  class ArrayListOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      # puts self
      # pp env
      # pp varname.text_value
      # pp list
      env[varname.text_value] ||= [ ] #varvalue.text_value
      env[varname.text_value].push(list.elements.find_all { |e| e.kind_of?(LvmBackup::StringLiteral) }.map { |e| e.text_value })
      env[varname.text_value].flatten!
      env
    end
  end

  
  # class ArrayAssignmentOperation < Treetop::Runtime::SyntaxNode
  #   def eval(env={})
  #     pp self
  #     env[varname.text_value] ||= [ ] #varvalue.text_value
  #     env[varname.text_value].push(varvalue.eval({}))
  #     env
  #   end
  # end
  
  class BlockOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env["#{name.text_value}"] = block_contents.eval({})
      env
    end
  end

  class QuotedStringLiteral < Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end

  
  class StringLiteral < Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end
end