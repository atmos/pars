require File.dirname(__FILE__) + "/../spec_helper"

describe Pars::NginxConfig::AST::WorkerProcesses, "events { \nworker_connections    8192;\n use epoll; }\n" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining events block" do
    before(:all) do
      @result = @parser.parse("events { \nworker_connections    8192;\n use epoll;\n}\n")
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should return 8192 connections" do
        @evaluated_result.worker_connections.should eql("8192")
        @evaluated_result.use.should eql("epoll")
      end
    end
  end
end