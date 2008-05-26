module LvmBackup
  class AssignmentOperation < Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value] = varvalue.text_value
      env
    end
  end

  class ArrayListOperation < Treetop::Runtime::SyntaxNode
    def collect_class_nodes(e,klass)
      found = [ ]
      e.elements.each do |e|
        found.push(e.collect_class_nodes(klass)) unless e.terminal?
      end
      found.flatten.compact
    end
    
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
end