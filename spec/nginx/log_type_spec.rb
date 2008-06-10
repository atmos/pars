require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::NginxConfig::AST::LogType, "access_log /var/log/nginx/access.log main" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining an access_log" do
    before(:all) do
      @result = @parser.parse("access_log /var/log/nginx/access.log main\n")
    end
    it "should return a parsed object" # do
     #      @result.should_not be_nil
     #    end
    describe "evaluating the result" do
      # before(:all) do
      #   @evaluated_result = @result.eval({})
      # end
      it "should return the log type" # do
       #        @evaluated_result.log_type.should eql('access')
       #      end
      it "should return the log path" # do
       #        @evaluated_result.path.should eql("/var/log/nginx/access.log")
       #      end
      it "should return the log level" # do
       #        @evaluated_result.level.should eql("main")
       #      end
    end
  end
end