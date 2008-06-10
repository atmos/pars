module NginxConfigFileYouShouldntUse
  class ConfigFile < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env
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
  
end