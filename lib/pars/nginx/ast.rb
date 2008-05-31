module Pars
  module NginxConfig
    module AST
      class User
        attr_accessor :user, :group
        def initialize(user, group)
          @user, @group = user, group
        end
      end
    end
  end
end