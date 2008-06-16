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
      
      class AccessLog
        attr_accessor :path, :level, :buffers
        def initialize(path, level, buffers)
          @path, @level, @buffers = path, level, buffers
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
        attr_accessor :name, :servers, :contents
        
        def initialize(name, servers, contents)
          @servers ||= [ ]
          servers.each do |server|
            host, port = server.split(/:/)
            @servers.push(UpstreamServer.new(host, port||80))
          end
          @name, @contents = name, contents
        end
      end
      
      class UpstreamServer
        attr_accessor :host, :port
        def initialize(host, port)
          @host, @port = host, port
        end
      end
      
      class IncludedFile
        attr_accessor :glob
        
        def initialize(glob)
          @glob = glob
        end
      end
      
      class Location
        attr_accessor :zomg
        
        def initialize(contents)
          pp contents
        end
      end
      class Server
        @@attribs = {:listen => 80, :root => '/data/myapp/current/public', :host => '0.0.0.0', :client_max_body_size => '50M'}
        attr_accessor :vars
        def initialize(contents)
          @vars = { }
          @@attribs.each do |k,v|
            @vars[k] = contents[k] || @@attribs[k]
          end
        end
      end
      class Comments
        attr_accessor :lines
        def initialize(lines)
          @lines = lines
        end
      end
    end
  end
end