module KeepAlivedConfigFile
  module AST
    class VrrpSyncGroup
      attr_accessor :group_name, :group, :contents, :notify_backup, :notify_master
      def initialize(group_name, contents)
        @group_name    = group_name
        @group         = contents[:group].keys
        @notify_backup = contents.delete(:notify_backup)
        @notify_master = contents.delete(:notify_master)
      end
    end
    
    class VrrpInstanceAuthentication
      attr_accessor :auth_type, :auth_pass
      def initialize(auth_type, auth_pass)
        @auth_type = auth_type
        @auth_pass = auth_pass
      end
    end
    
    class VrrpInstanceVirtualIpAddress
      attr_accessor :ip_address, :device, :interface
      def initialize(address, device, interface)
        @ip_address = address.to_s
        @device     = device
        @interface  = interface
      end
    end
    
    class VrrpInstance
      attr_accessor :name, :advert_int, :priority, :state, :interface
      attr_accessor :lvs_sync_daemon_interface, :virtual_router_id
      attr_accessor :authentication, :virtual_ipaddresses
      def initialize(name, contents)
        @name                        = name
        @advert_int                  = contents[:advert_int]
        @state                       = contents[:state]
        @priority                    = contents[:priority]
        @interface                   = contents[:interface]
        @lvs_sync_daemon_interface   = contents[:lvs_sync_daemon_interface]
        @virtual_router_id           = contents[:virtual_router_id]
        @authentication              = VrrpInstanceAuthentication.new(contents[:authentication][:auth_type], contents[:authentication][:auth_pass])
        @virtual_ipaddresses         = contents[:virtual_ipaddress].collect do |key,value|
          VrrpInstanceVirtualIpAddress.new(key, value[0], value[1])
        end
        @virtual_ipaddresses.sort!{ |a,b| a.ip_address <=> b.ip_address }
      end
    end

    class ServerCheck
      attr_accessor :connect_port, :connect_timeout, :nb_get_retry, :delay_before_retry
      def initialize(connect_port, connect_timeout, nb_get_retry, delay_before_retry, contents = nil)
        @connect_port, @connect_timeout = connect_port, connect_timeout
        @nb_get_retry, @delay_before_retry = nb_get_retry, delay_before_retry
      end
    end
    
    class TcpServerCheck < ServerCheck; end

    class HttpServerCheck < ServerCheck
      attr_accessor :path, :status_code
      def initialize(connect_port, connect_timeout, nb_get_retry, delay_before_retry, contents)
        super(connect_port, connect_timeout, nb_get_retry, delay_before_retry, contents)
        @path        = contents[:url][:path]
        @status_code = contents[:url][:status_code]
      end
    end

    class IpMapping
      attr_accessor :ip, :port
      def initialize(ip, port)
        @ip, @port = ip, port
      end
    end

    class RealServer
      attr_accessor :ip, :port, :weight, :check
      def initialize(ip, port, contents)
        @ip     = ip
        @port   = port
        @weight = contents[:weight]
        unless contents[:TCP_CHECK].nil?
          params = contents[:TCP_CHECK]
          @check = TcpServerCheck.new(params[:connect_port], 
                                      params[:connect_timeout], 
                                      params[:nb_get_retry], 
                                      params[:delay_before_retry])
        end
        unless contents[:HTTP_GET].nil?
          params = contents[:HTTP_GET]
          @check = HttpServerCheck.new(params[:connect_port],
                                       params[:connect_timeout],
                                       params[:nb_get_retry],
                                       params[:delay_before_retry], params)
        end
      end
    end

    class VirtualServer
      attr_accessor :ip, :port
      attr_accessor :delay_loop, :lb_algo, :lb_kind
      attr_accessor :nat_mask, :persistence_timeout
      attr_accessor :protocol, :sorry_server, :virtualhost
      def initialize(ip, port, contents)
        @ip                  = ip
        @port                = port
        @delay_loop          = contents[:delay_loop]
        @lb_algo             = contents[:lb_algo]
        @lb_kind             = contents[:lb_kind]
        @nat_mask            = contents[:nat_mask]
        @persistence_timeout = contents[:persistence_timeout]
        @protocol            = contents[:protocol]
        @sorry_server        = IpMapping.new(contents[:sorry_server][0], contents[:sorry_server][1]) rescue nil
        @virtualhost         = contents[:virtualhost] rescue nil
      end
    end
  end
end