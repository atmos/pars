require File.dirname(__FILE__) + '/../spec_helper'

describe KeepAlivedConfigFile::AST::VrrpInstance, "vrrp_instance { } in keepalived.conf" do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  it "should not be nil" do
    @parser.should_not be_nil
  end
  describe " calling .parse" do
    describe "with one parameter" do
      before(:all) do
        str = <<-EOF
        vrrp_instance EY04_LBA_AOE {
          state MASTER
          interface external
          lvs_sync_daemon_interface internal
          virtual_router_id 49
          priority 100
          advert_int 3
          authentication {
            auth_type PASS
            auth_pass 1111
          }
          virtual_ipaddress {
            192.168.0.254/32 dev aoe0
          }
        }
EOF
        @result = @parser.parse(str)
      end
      it "should return a parse representation of the assignment" do
        @result.should_not be_nil
      end
      it "should return a config file you shouldn't use" do
        @result.should be_a_kind_of(KeepAlivedConfigFileYouShouldntUse::ConfigFile)
      end
      describe " calling .eval" do
        before(:all) do
          @evaluated_result = @result.eval({})[:vrrp_instances].first
        end
        it "should return the group name" do
          @evaluated_result.name.should == 'EY04_LBA_AOE'
        end
        
        it "should return a value for advert_int" do
          @evaluated_result.advert_int.should eql("3")
        end
        
        it "should return a value for priority" do
          @evaluated_result.priority.should eql("100")
        end
        
        it "should return a value for state" do
          @evaluated_result.state.should eql("MASTER")
        end
        
        it "should return an interface" do
          @evaluated_result.interface.should eql("external")
        end
        
        it "should lvs_sync_daemon_interface" do
          @evaluated_result.lvs_sync_daemon_interface.should eql("internal")
        end
        it "should return a virtual_router_id" do
          @evaluated_result.virtual_router_id.should eql("49")
        end

        describe " calling .authentication" do
          it "should return an authentication object" do
            @evaluated_result.authentication.should_not be_nil
          end

          it "should return an authentication type" do
            @evaluated_result.authentication.auth_type.should eql("PASS")
          end

          it "should return an authentication pass" do
            @evaluated_result.authentication.auth_pass.should eql("1111")
          end
        end

        describe " calling .virtual_ipaddress" do
          it "should return a virtual ipaddress" do
            @evaluated_result.virtual_ipaddress.should_not be_nil
          end

          it "should return a virtual ipaddress's ip address" do
            @evaluated_result.virtual_ipaddress.ip_address.should eql('192.168.0.254/32')
          end
          it "should return a virtual ipaddress's device" do
            @evaluated_result.virtual_ipaddress.device.should eql("dev")
          end

          it "should return a virtual ipaddress's tag" do
            @evaluated_result.virtual_ipaddress.tag.should eql("aoe0")
          end
          
        end
      end
    end
  end
end