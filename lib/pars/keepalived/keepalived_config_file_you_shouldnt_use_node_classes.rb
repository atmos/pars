module KeepAlivedConfigFileYouShouldntUse
  class ConfigFile < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      elements.each do |e|
        begin
          result = e.eval(env)
          if result.kind_of?(String)
            pp result if env.nil?
            env[result] = nil
          else
            env.merge(result)
          end
        rescue => exception
          # pp e
          puts exception.backtrace
          pp "ZOMFG #{exception.message}"
        end
      end
      env
    end
  end

  class CommentNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={}); env end
  end

  class VrrpSyncGroupNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[:vrrp_groups] ||= [ ]
      group = ::KeepAlivedConfigFile::AST::VrrpSyncGroup.new(block_param.eval(env), block_contents.eval({}))
      env[:vrrp_groups].push(group)
      env
    end
  end

  class VrrpInstanceNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      node = ::KeepAlivedConfigFile::AST::VrrpInstance.new(block_param.eval(env), block_contents.eval({}))
      env[:vrrp_instances] ||= [ ]
      env[:vrrp_instances].push(node)
      env
    end
  end

  class RealServerNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      rs = ::KeepAlivedConfigFile::AST::RealServer.new(ip.eval(env), port.eval(env), block_contents.eval({}))
      env[:real_servers] ||= [ ]
      env[:real_servers].push(rs)
      env
    end
  end

  class VirtualServerNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      vs = ::KeepAlivedConfigFile::AST::VirtualServer.new(ip.eval(env), port.eval(env), block_contents.eval({}))
      env[:virtual_servers] ||= [ ]
      env[:virtual_servers].push(vs)
      env
    end
  end

  class DefinitionNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value.to_sym] = true
      env
    end
  end
  class TwoElementAssignmentNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[varname.text_value.to_sym] = [varvalue1.eval(env), varvalue2.eval(env)]
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