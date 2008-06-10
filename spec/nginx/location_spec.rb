require File.dirname(__FILE__) + "/../spec_helper"

describe Pars::NginxConfig::AST::Location, "location { ... }" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining server block" do
    before(:all) do
      @result = @parser.parse(fixture("nginx/server.conf"))
    end
    it "should return a parsed object" # do
     #      @result.should_not be_nil
     #    end
    describe "evaluating the result" do
      # before(:all) do
      #   @evaluated_result = @result.eval({})
      # end
      it "should set deny to 'application/octet-stream'" # do
       #        @evaluated_result.default_type.should eql("application/octet-stream")
       #      end
      # TODO: add allow to config
      #it "should set allow to '10.0.5.1'" do
      #  @evaluated_result.allow.should eql("10.0.5.1")
      #end
      it "should set proxy_set_header key to 'X-Real-IP' and value to '$remote_addr'" # do
       #        @evaluated_result.proxy_set_header.key.should eql("X-Real-IP")
       #        @evaluated_result.proxy_set_header.value.should eql("$remote_addr")
       #      end
      it "should set proxy_set_header key to 'X-Forwarded-For' and value to '$proxy_add_x_forwarded_for'" # do
       #        @evaluated_result.proxy_set_header.key.should eql("X-Forwarded-For")
       #        @evaluated_result.proxy_set_header.value.should eql("$proxy_add_x_forwarded_for")
       #      end
      it "should set proxy_set_header key to 'Host' and value to '$http_host'" # do
       #        @evaluated_result.proxy_set_header.key.should eql("Host")
       #        @evaluated_result.proxy_set_header.value.should eql("$http_host")
       #      end
      it "should set proxy_redirect to 'false'" # do
       #        @evaluated_result.proxy_redirect.should eql("false")
       #      end
      it "should set proxy_max_temp_file_size to '0'" # do
       #        @evaluated_result.proxy_max_temp_file_size.should eql("0")
       #      end
      # TODO: IF
    end
  end
end