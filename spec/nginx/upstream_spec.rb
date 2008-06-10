require File.dirname(__FILE__) + "/../spec_helper"

describe Pars::NginxConfig::AST::Upstream, "upstream application { ... }" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining events block" do
    before(:all) do
      @result = @parser.parse("upstream application { \n  server 127.0.0.1:1234; \n  server 127.0.0.1:4321; \n }")
      # pp @parser
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})[:upstreams].first
      end
      it "should return server with host '127.0.0.1' and port '1234' and another with port 4321" do
        @evaluated_result.name.should eql("application")
        @evaluated_result.servers.first.host.should eql("127.0.0.1")
        @evaluated_result.servers.first.port.should eql("1234")
        @evaluated_result.servers.last.host.should eql("127.0.0.1")
        @evaluated_result.servers.last.port.should eql("4321")
      end
    end
  end
end