module NginxConfigFileYouShouldntUse
  class ConfigFile < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      # pp env.eval({})
    end
  end
  
  class UserNode < ::Treetop::Runtime::SyntaxNode
    def eval(env = { })
      env[:user] = Pars::NginxConfig::AST::User.new(user.eval(env), group.eval(env))
    end
  end

  class PidFileNode < ::Treetop::Runtime::SyntaxNode
    def eval(env = { })
      env[:pidfile] = Pars::NginxConfig::AST::PidFile.new(file.eval(env))
    end
  end

  class WorkerProcessesNode < ::Treetop::Runtime::SyntaxNode
    def eval(env = { })
      env[:worker_processes] = Pars::NginxConfig::AST::WorkerProcesses.new(count.eval(env))
    end
  end

  class EventsNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      values = definitions.elements.inject({}) do |sum, part|
        sum.merge(part.eval(env))
      end
      env[:events] = Pars::NginxConfig::AST::Events.new(values)
    end
  end

  class DefinitionNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[key.eval(env).to_sym] = value.eval(env)
      env
    end
  end

  class GlobNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end
  
  class VariableNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end

  class CommentsNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      values = [ ]
      elements.each do |part|
        values.push(part.text_value)
      end
      env[:comments] ||= [ ]
      env[:comments].push(Pars::NginxConfig::AST::Comments.new(values))
      
      # values.each do |value|
      #   pp value
      # end
    end
  end
  
  class CommentNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={}); env end
  end
  
  class AccessLogNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      buffers = buffers.eval(env) rescue ''
      env[:access_logs] = Pars::NginxConfig::AST::AccessLog.new(path.eval(env), level.eval(env), buffers)
      env 
    end
  end
  
  class IncludedFile < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env[:includes] ||= [ ]
      env[:includes].push(Pars::NginxConfig::AST::IncludedFile.new(value.eval(env)))
      env 
    end
  end
  
  class UpstreamNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      values = definitions.elements.inject({}) do |sum, part|
        evaluated = part.eval(env)
        unless evaluated.nil?
          unless evaluated[:server].nil?
            sum[:servers] ||= [ ]
            sum[:servers].push(evaluated[:server])
          else
            sum.merge(evaluated)
          end
        end
        sum
      end
      env[:upstreams] ||= [ ]
      env[:upstreams].push(Pars::NginxConfig::AST::Upstream.new(name.eval(env), values.delete(:servers), values))
      env 
    end
  end
  
  class ServerNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      values = definitions.elements.inject({}) do |sum, element|
        element.eval(sum)
        sum
      end
      env[:servers] ||= [ ]
      env[:servers].push(Pars::NginxConfig::AST::Server.new(env))
      env
    end
  end
end