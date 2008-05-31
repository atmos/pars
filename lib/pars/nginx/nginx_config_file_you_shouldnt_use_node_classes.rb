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

  
  class VariableNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      text_value
    end
  end
  
  class CommentNode < ::Treetop::Runtime::SyntaxNode
    def eval(env={}); env end
  end
end