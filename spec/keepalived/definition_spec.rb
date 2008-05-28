require File.dirname(__FILE__) + '/../spec_helper'

describe Kernel do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  describe "calling .parse" do
    describe "with no parameters" do
      before(:all) do
        @result = @parser.parse("lvs_sync_daemon_interface\n")
      end
      it "should return a parse representation of the assignment" do
        @result.should_not be_nil
      end
      it "should return a config file you shouldn't use" do
        @result.should be_a_kind_of(KeepAlivedConfigFileYouShouldntUse::ConfigFile)
      end
      describe "calling .eval on the result" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return the value of the assignment" do
          @evaluated_result[:lvs_sync_daemon_interface].should be_true
        end
      end
    end
  end
end