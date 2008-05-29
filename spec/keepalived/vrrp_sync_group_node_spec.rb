require File.dirname(__FILE__) + '/../spec_helper'

describe KeepAlivedConfigFile::AST::VrrpSyncGroup, "vrrp_sync_group { } in keepalived.conf" do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  it "should not be nil" do
    @parser.should_not be_nil
  end
  describe " calling .parse" do
    describe "with one parameter" do
      before(:all) do
        @result = @parser.parse("vrrp_sync_group EY04_LBA {\ngroup {\nEY04_LBA_INT\nEY04_LBA_AOE\nEY04_LBA_EXT1\n}\nnotify_master /etc/keepalived/be_master\nnotify_backup /etc/keepalived/be_backup\n}\n")
      end
      it "should return a parse representation of the assignment" do
        @result.should_not be_nil
      end
      it "should return a config file you shouldn't use" do
        @result.should be_a_kind_of(KeepAlivedConfigFileYouShouldntUse::ConfigFile)
      end
      describe " calling .eval" do
        before(:all) do
          @evaluated_result = @result.eval({})[:vrrp_groups].first
        end
        it "should return the group name" do
          @evaluated_result.group_name.should == 'EY04_LBA'
        end
        it "should return the contents name" do
          @evaluated_result.group.should be_a_kind_of(Array)
        end
        it "should notify_master variable" do
          @evaluated_result.notify_master.should eql('/etc/keepalived/be_master')
        end
        it "should notify_backup variable" do
          @evaluated_result.notify_backup.should eql('/etc/keepalived/be_backup')
        end
        
      end
    end
  end
end