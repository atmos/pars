require File.dirname(__FILE__) + '/../spec_helper'

describe NginxConfigFileYouShouldntUse::DefinitionNode, " # a comment " do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "given a two line comment" do
    before(:all) do
      @result = @parser.parse("#worker_connections 8192;\n#woot\n")
      # pp @parser
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should have a key value for the variable name" do
        @evaluated_result.first.lines.should have(2).things
      end
    end
  end
end