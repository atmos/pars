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
        attr_accessor :worker_processes
        attr_accessor :use
        def initialize(contents)
          @worker_processes = contents[:worker_processes]
          @use = contents[:use]
        end
      end
    end
  end
end