require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::Monit::Parser, "monit's XML data exported" do
  before(:all) do
    @parser = Pars::Monit::Parser.new
  end
  describe "parsing from file" do
    before(:all) do
      @result = @parser.parse(File.dirname(__FILE__)+'/../fixtures/monit/monit_output.xml')
    end
    it "should return a hash" do
      @result.should be_a_kind_of(Pars::Monit::Result)
    end
    
    describe Pars::Monit::Services, ".services" do
      before(:all) do
        @services = @result.services
      end
      it "should have return a hash of services" do
        @services.should be_a_kind_of(Pars::Monit::Services)
      end
      it "should return a list of named services running" do
        services = %w(mongrel_xyzserver_5300 mongrel_xyzserver_5301 mongrel_xyzserver_5302 merb_xyzrender_5400 memcache_xyzserver_11211 backgroundrb_xyzserver_11006 ey02-s00146)
        @services.names.should == services
      end

      describe Pars::Monit::Service, "a service running under monit" do
        before(:all) do
          @service = @services['mongrel_xyzserver_5300']
        end
        it "should return the pid of the process" do
          @service.pid.should == 13473
        end
        it "should return the status of the process" do
          @service.status.should == 13473
        end
        it "should return the name of the service" do
          @service.name.should == 'mongrel_xyzserver_5300'
        end
        it "should return memory used by the service" do
          @service.memory.should == {'kilobyte' => "75940", 'percenttotal' => '40.9', 'percent' => '9.3', 'kilobytetotal' => '331480' }
        end
        it "should indicated whether it's being monitored or not" do
          @service.should be_monitored
        end
        it "should know its service type" do
          @service.service_type.should == 3
        end
        it "should return cpu used by the service" do
          @service.cpu.should == {'user' => "35.9", 'wait' => '1.3', 'system' => '11.4' }
        end
        it "should return the monit group it belongs to" do
          @service.group.should == 'xyzserver'
        end
        it "should return the load average for the system" do
          @service.load.should == {'avg15' => '0.21', 'avg05' => '0.34', 'avg01' => '0.49' }
        end
        it "should return the date the data was collected on" do
          @service.collected.should == Time.local(1211856243)
        end
        it "should return an Array of the child pid numbers" do
          @service.children.should == [ 0 ]
        end
        it "should return its parent pid" do
          @service.ppid.should == '-1'
        end
        it "should know its own pending actions" do
          @service.pending_action.should == 0
        end
      end
    end
  end
end