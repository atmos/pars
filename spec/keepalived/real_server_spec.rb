require File.dirname(__FILE__) + '/../spec_helper'

describe KeepAlivedConfigFile::AST::RealServer, "real_server { } in keepalived.conf" do
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
        real_server 10.4.192.34 80 {
          weight 1
          TCP_CHECK {
            connect_port 80
            connect_timeout 2
            nb_get_retry 20
            delay_before_retry 2
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
          @evaluated_result = @result.eval({})[:real_servers].first
        end
        it "should return its ip address" do
          @evaluated_result.ip.should eql('10.4.192.34')
        end
        it "should return its port number" do
          @evaluated_result.port.should eql('80')
        end
        it "should return its weight" do
          @evaluated_result.weight.should eql('1')
        end
        describe " calling .check" do
          before(:all) do
            @check = @evaluated_result.check
          end
          it "should return a real server check" do
            @check.should_not be_nil
          end
          it "should return a connect port" do
            @check.connect_port.should eql('80')
          end
          it "should return a connect_timeout" do
            @check.connect_timeout.should eql('2')
          end
          it "should return nb_get_retry" do
            @check.nb_get_retry.should eql('20')
          end
          it "should return delay_before_retry" do
            @check.delay_before_retry.should eql('2')
          end
        end
      end
    end
  end
end