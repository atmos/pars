require File.dirname(__FILE__) + '/../spec_helper'

describe NginxConfigFileYouShouldntUse::Definition, "worker_processes 6;" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining a user and group" do
    before(:all) do
      @result = @parser.parse("user atmos;\n")
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should have a key value for the variable name" do
        @evaluated_result[:user].should_not be_nil
      end
      it "should return a value for the key" do
        @evaluated_result[:user].should eql('atmos')
      end
    end
  end
end