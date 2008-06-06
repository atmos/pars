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

      class LogFormat
        attr_accessor :log_type, :format
        def initialize(log_type, format)
          @log_type, @format = log_type, format
        end
      end

      
      class LogType
        attr_accessor :path, :level, :log_type
        def initialize(log_type, path, level)
          @log_type, @path, @level = log_type, path, level
        end
      end
      
      class IncludeFile
        attr_accessor :glob
        def initialize(glob)
          @glob = glob
        end
      end
      
      class Events
        attr_accessor :worker_connections, :use
        def initialize(contents)
          %w(worker_connections use).
          each do |definition|
            instance_variable_set "@#{definition}", contents[definition.to_sym]
          end
        end
      end
      
      class Http
        attr_accessor :include_files, :default_type, :access_log, :error_log , :sendfile, :tcp_nopush, :tcp_nodelay, :gzip, :gzip_http_version, :gzip_comp_level, :gzip_proxied, :gzip_buffers, :gzip_types, :gzip_disable
        
        def initialize(contents)
          %w(include_files default_type access_log error_log  sendfile tcp_nopush tcp_nodelay gzip gzip_http_version gzip_comp_level gzip_proxied gzip_buffers gzip_types gzip_disable).
          each do |definition|
            instance_variable_set "@#{definition}", contents[definition.to_sym]
          end
        end
      end

      class Upstream
        attr_accessor :servers
        
        def initialize(contents)
          pp contents
        end
      end

      class Location
        attr_accessor :zomg
        
        def initialize(contents)
          pp contents
        end
      end
      class Server
        attr_accessor :zomg
        
        def initialize(contents)
          pp contents
        end
      end
    end
  end
end