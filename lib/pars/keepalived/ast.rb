module KeepAlivedConfigFile
  module AST
    class VrrpSyncGroup
      attr_accessor :group_name, :group, :contents, :notify_backup, :notify_master
      def initialize(group_name, contents)
        @group_name = group_name
        @group = contents[:group].keys
        @contents = contents
        @notify_backup = contents.delete(:notify_backup)
        @notify_master = contents.delete(:notify_master)
      end
    end
    
    # :advert_int=>"3",
    #  :priority=>"100",
    #  :state=>"MASTER",
    #  :authentication=>{:auth_type=>"PASS", :auth_pass=>"1111"},
    #  :interface=>"external",
    #  :lvs_sync_daemon_interface=>"internal",
    #  :virtual_ipaddress=>{:"192.168.0.254/32"=>["dev", "aoe0"]},
    #  :virtual_router_id=>"49"
    
    class VrrpInstanceAuthentication
      attr_accessor :auth_type, :auth_pass
      def initialize(auth_type, auth_pass)
        @auth_type = auth_type
        @auth_pass = auth_pass
      end
    end
    
    class VrrpInstanceVirtualIpAddress
      attr_accessor :ip_address, :device, :tag
      def initialize(address, device, tag)
        @ip_address = address.to_s
        @device     = device
        @tag        = tag
      end
    end
    
    class VrrpInstance
      attr_accessor :name, :advert_int, :priority, :state, :interface
      attr_accessor :lvs_sync_daemon_interface, :virtual_router_id
      attr_accessor :authentication, :virtual_ipaddress
      def initialize(name, contents)
        @name                        = name
        @advert_int                  = contents[:advert_int]
        @state                       = contents[:state]
        @priority                    = contents[:priority]
        @interface                   = contents[:interface]
        @lvs_sync_daemon_interface   = contents[:lvs_sync_daemon_interface]
        @virtual_router_id           = contents[:virtual_router_id]
        @authentication              = VrrpInstanceAuthentication.new(contents[:authentication][:auth_type], contents[:authentication][:auth_pass])
        contents[:virtual_ipaddress].each do |key,value|
          @virtual_ipaddress         = VrrpInstanceVirtualIpAddress.new(key, value[0], value[1])
        end
      end
    end
    
  end
end