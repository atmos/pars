module NginxConfigFileYouShouldntUse
  class ConfigFile < ::Treetop::Runtime::SyntaxNode
    def eval(env={})
      env
    end
  end
end