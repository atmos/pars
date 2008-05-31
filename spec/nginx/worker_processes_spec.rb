require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::NginxConfig::AST::WorkerProcesses, "worker_processes 6;" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining a user and group" do
    before(:all) do
      @result = @parser.parse("worker_processes 6;\n")
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should return a user" do
        @evaluated_result.count.should eql("6")
      end
    end
  end
end