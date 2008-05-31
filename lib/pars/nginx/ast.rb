module Pars
  module NginxConfig
    module AST
      class User
        attr_accessor :user, :group
        def initialize(user, group)
          @user, @group = user, group
        end
      end
      class PidFile
        attr_accessor :file
        def initialize(file)
          @file = file
        end
      end
      class WorkerProcesses
        attr_accessor :count
        def initialize(count)
          @count = count
        end
      end
    end
  end
end