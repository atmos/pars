require File.dirname(__FILE__) + '/../spec_helper'

describe KeepAlivedConfigFileYouShouldntUse::AssignmentNode, "variable assignment in keepalived.conf" do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  it "should not be nil" do
    @parser.should_not be_nil
  end
  describe " calling .parse" do
    describe "with one parameter" do
      before(:all) do
        @result = @parser.parse("lvs_sync_daemon_interface internal\n")
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
          @evaluated_result[:lvs_sync_daemon_interface].should eql("internal")
        end
      end
      describe "multiline with two parameters" do
        before(:all) do
          @result = @parser.parse("192.168.0.254/32 dev aoe0\n")
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
          it "should return the value of the first assignment" do
            @evaluated_result[:"192.168.0.254/32"].should eql(['dev', 'aoe0'])
          end
        end
      end
    end
    describe "multiline with one parameter each" do
      before(:all) do
        @result = @parser.parse("notify_master /etc/keepalived/be_master\nnotify_backup /etc/keepalived/be_backup\n")
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
        it "should return the value of the first assignment" do
          @evaluated_result[:notify_master].should eql("/etc/keepalived/be_master")
        end
        it "should return the value of the second assignment" do
          @evaluated_result[:notify_backup].should eql("/etc/keepalived/be_backup")
        end
      end
    end
  end
end