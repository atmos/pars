require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::NginxConfig::AST::LogFormat, "log_format main '$remote_addr - $remote_user [$time_local] ';" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining a user and group" do
    before(:all) do
      @result = @parser.parse("log_format main '$remote_addr - $remote_user [$time_local] ';\n")
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
    end
  end
end