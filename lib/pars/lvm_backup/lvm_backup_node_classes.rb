module LvmBackup
  class AssignmentOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value] = varvalue.eval(env)
      env
    end
  end

  class ArrayListOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value] ||= [ ] #varvalue.text_value
      elements = list.elements
      
      until elements.empty? do
        e = elements.pop
        size = env[varname.text_value].size
        if e.kind_of?(LvmBackup::QuotedStringLiteral)
          env[varname.text_value].insert(size == 0 ? 0 : 1, e.eval({}))
        elsif e.kind_of?(Treetop::Runtime::SyntaxNode)
          elements.insert(0, e.elements)
        elsif e.kind_of?(Array)
          elements.insert(0, e)
        else
          pp e
          raise ArgumentError, "ZOMG I got a #{e.class.name}"
        end
        elements = elements.flatten.compact
      end
      env[varname.text_value].flatten!
      env
    end
  end

  class BlockOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env["#{name.text_value}"] = block_contents.eval({})
      env
    end
  end

  class QuotedStringLiteral < Treetop::Runtime::SyntaxNode
    def eval(env={})
      varname.text_value
    end
  end

  class StringLiteral < Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end
  
  class NumberNode < Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value.to_i
    end
  end
  
  class FileContents < Treetop::Runtime::SyntaxNode
    def eval(env={})
      elements.each do |e|
        result = e.eval(env)
        result.kind_of?(String) ? env[result] = nil : env.merge(result)
      end
      env
    end
  end

  class DummyNode < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env
    end
  end
  class CommentNode < DummyNode; end
  
end