require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::NginxConfig::AST::IncludeFile, "include /data/foo/*.conf" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "including a glob of files" do
    before(:all) do
      @result = @parser.parse("include /etc/nginx/sites/*.conf;\n")
    end
    it "should return a parsed object" # do
     #      @result.should_not be_nil
     #    end
    describe "evaluating the result" do
      # before(:all) do
      #   @evaluated_result = @result.eval({})
      # end
    end
  end
end