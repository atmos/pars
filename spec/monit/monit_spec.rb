require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::Monit::Parser, "monit's XML data fetched from http" do
  before(:all) do
    @parser = Pars::Monit::Parser.new
  end
  describe " calling .parse" do
    before(:all) do
      @result = @parser.parse(File.dirname(__FILE__)+'/../fixtures/monit/monit_output.xml')
    end
    it "should return a hash" do
      @result.should be_a_kind_of(Pars::Monit::ParseResult)
    end
    
    describe ".services" do
      before(:all) do
        @services = @result.services
      end
      it "should have return a hash of services" do
        @services.should be_a_kind_of(Pars::Monit::Services)
      end
      it "should return a list of named services running" do
        services = [:backgroundrb_xyzserver_11006, :"ey02-s00146", :memcache_xyzserver_11211, :merb_xyzrender_5400, :mongrel_xyzserver_5300, :mongrel_xyzserver_5301, :mongrel_xyzserver_5302]
        @services.names.should == services
      end

      describe " a service" do
        before(:all) do
          @service = @services['mongrel_xyzserver_5301']
        end
        it "should return the pid of the process" do
          @service.pid.should == -1
        end
        it "should return the status of the process" do
          @service.status.should == 2
        end
        it "should return the name of the service" do
          @service.name.should == 'mongrel_xyzserver_5301'
        end
        it "should return memory used by the service" do
          @service.memory.should == {:kilobyte => "0", :percenttotal => '0.0', :percent => '0.0', :kilobytetotal => '0' }
        end
        it "should indicate whether it's being monitored or not" do
          @service.should be_monitored
        end
        it "should know its service type" do
          @service.monitor_type.should == 1
        end
        it "should know its own pending actions" do
          @service.pending_action.should == 0
        end
        it "should return cpu used by the service" do
          @service.cpu.should == {:percenttotal=>"0.0", :percent=>"0.0"}
        end
        it "should return the monit group it belongs to" do
          @service.group.should == 'xyzserver'
        end
        it "should return the date the data was collected on" do
          @service.collected.should == Time.at(1211856243)
        end
      end

      describe "returning a monit service reporting load average" do
        before(:all) do
          @service = @services['ey02-s00146']
        end
        it "should return the load average for the system" do
          @service.load.should == {:avg15 => '0.21', :avg05 => '0.34', :avg01 => '0.49' }
        end
      end
      
      describe "returning a monit service with a parent pid" do
        before(:all) do
          @service = @services['backgroundrb_xyzserver_11006']
        end
        it "should return the parent pid for the monitored process" do
          @service.ppid.should == 1
        end
        it "should return the number of children" do
          @service.children.should == 3
        end
      end
    end
  end
end