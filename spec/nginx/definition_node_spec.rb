require File.dirname(__FILE__) + '/../spec_helper'

describe NginxConfigFileYouShouldntUse::DefinitionNode, "worker_connections 8192;" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining worker_connections 8192" do
    before(:all) do
      @result = @parser.parse("worker_connections 8192;\n")
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should have a key value for the variable name" do
        @evaluated_result[:worker_connections].should_not be_nil
      end
      it "should return a value for the key" do
        @evaluated_result[:worker_connections].should eql('8192')
      end
    end
  end
end