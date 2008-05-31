require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::NginxConfig::AST::User, "user atmos wheel;" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining a user and group" do
    before(:all) do
      @result = @parser.parse("user atmos wheel;\n")
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should return a user" do
        @evaluated_result.user.should eql('atmos')
      end
      it "should return a group" do
        @evaluated_result.group.should eql('wheel')
      end
    end
  end
end