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
      class Events
        attr_accessor :worker_connections
        attr_accessor :use
        def initialize(contents)
          @worker_connections = contents[:worker_connections]
          @use = contents[:use]
        end
      end
    end
  end
end