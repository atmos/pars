describe KeepAlivedConfigFile::AST::VirtualServer, "virtual_server { } in keepalived.conf" do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  it "should not be nil" do
    @parser.should_not be_nil
  end
  describe " calling .parse" do
    describe "with an ip and port as a parameter" do
      before(:all) do
        str = <<-EOF
        virtual_server 169.254.1.1 80 {
            delay_loop 15
            lb_algo lc
            lb_kind NAT
            nat_mask 255.255.255.0
            persistence_timeout 0
            protocol TCP
            sorry_server 127.0.0.1 80
            virtualhost www.myfacetube.com
            real_server 10.0.1.34 80 {
              weight 1
              HTTP_GET {
                url {
                  path /fitter_happier
                  status_code 200
                }
                connect_port 80
                connect_timeout 5
                nb_get_retry 20
                delay_before_retry 2
              }
            }
            real_server 10.0.1.35 80 {
              weight 1
              HTTP_GET {
                url {
                  path /fitter_happier
                  status_code 200
                }
                connect_port 80
                connect_timeout 5
                nb_get_retry 20
                delay_before_retry 2
              }
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
          @evaluated_result = @result.eval({})[:virtual_servers].first
        end
        
        it "should return a delay_loop" do
          @evaluated_result.delay_loop.should eql('15')
        end
        it "should return an lb_algo" do
          @evaluated_result.lb_algo.should eql('lc')
        end
        it "should return an lb_kind" do
          @evaluated_result.lb_kind.should eql('NAT')
        end
        it "should return a nat_mask" do
          @evaluated_result.nat_mask.should eql('255.255.255.0')
        end
        it "should return a persistence_timeout" do
          @evaluated_result.protocol.should eql('TCP')
        end
        it "should return the virtualhost" do
          @evaluated_result.virtualhost.should eql('www.myfacetube.com')
        end
        
        describe " sorry_server " do
          it "should return an ip" do
            @evaluated_result.sorry_server.ip.should eql('127.0.0.1')
          end
          it "should return an ip" do
            @evaluated_result.sorry_server.port.should eql('80')
          end
        end
      end
    end
  end
end