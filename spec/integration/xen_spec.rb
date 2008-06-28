require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::Xen::Parser, "parsing" do
  before(:all) do
    @parser = Pars::Xen::Parser.new
  end
  describe "ey00-s000348.xen as input" do
     before(:all) do
       @result = @parser.parse(File.read(File.dirname(__FILE__)+'/../fixtures/xen/ey00-s00348.xen'))
     end
     it "shouldn't be nil" do
       @result.should_not be_nil
     end
     it "should return a kind of XenConfigFileYouShouldntUse::ConfigFileNode" do
       @result.should be_a_kind_of(XenConfigFileYouShouldntUse::ConfigFileNode)
     end
     
     describe "evaluated output" do
       before(:all) do
         @evaluated_result = @result.eval
       end
       it "should return a hash of the evaluated string" do
         @evaluated_result.should be_a_kind_of(Hash)          
       end

       describe " variables defined" do
         before(:all) do
           @vars = @evaluated_result
         end
         it "should know the cpu_cap" do
           @vars[:cpu_cap].should == 100
         end
         it "should know the root disk" do
           @vars[:root].should == '/dev/sda1 ro'
         end
         it "should know the name for the domain" do
           @vars[:name].should == "ey00-s00348"
         end
         it "should know the kernel for the domain" do
           @vars[:kernel].should == "/boot/vmlinuz-2.6.18-xenU"
         end
         it "should know the vcpu count for the domain" do
           @vars[:vcpus].should == 1
         end
         it "should know the maxmem settings for the domain" do
           @vars[:maxmem].should == 4096
         end
         it "should know the virtual interfaces" do
           @vars[:vif].should == ["bridge=xenbr0"]
         end
         it "should know the memory allocated for the domain" do
           @vars[:memory].should == 712
         end
         it "should know about the disks exposed to the domain" do
           @vars[:disk].should == ["phy:/dev/ey00-data4/root-s00348,sda1,w", "phy:/dev/ey00-data4/swap-s00348,sda2,w", "phy:/dev/ey00-data4/gfs-00218,sdb1,w!"]
         end
       end
     end
   end
end