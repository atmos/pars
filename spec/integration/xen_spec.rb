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
       it "should return an AST instance of the config file" do
         @evaluated_result.should be_a_kind_of(XenConfigFile::AST::ConfigFile)          
       end

       describe " variables " do
         before(:all) do
           @vars = @evaluated_result
         end
         
         it "should know the cpu_cap" do
           @vars.vars[:cpu_cap].should == 100
         end
         it "should know the root disk" do
           @vars.vars[:root].should == '/dev/sda1 ro'
         end
         it "should know the name for the domain" do
           @vars.vars[:name].should == "ey00-s00348"
         end
         it "should know the kernel for the domain" do
           @vars.vars[:kernel].should == "/boot/vmlinuz-2.6.18-xenU"
         end
         it "should know the vcpu count for the domain" do
           @vars.vars[:vcpus].should == 1
         end
         it "should know the maxmem settings for the domain" do
           @vars.vars[:maxmem].should == 4096
         end
         it "should know the virtual interfaces" do
           @vars.vars[:vif].should == ["bridge=xenbr0"]
         end
         it "should know the memory allocated for the domain" do
           @vars.vars[:memory].should == 712
         end
         
         describe "disks" do
           before(:all) do
             @disks = @vars.disks
           end
           it "should know about the disks exposed to the domain" do
             @disks.should have(3).entries
           end

           describe "variables" do
             before(:all) do
               @disk = @disks.first
             end
             it "should know the volume" do
               @disk.volume.should == 'phy:/dev/ey00-data4/root-s00348'
             end
             it "should know the device" do
               @disk.device.should == 'sda1'
             end
             it "should know the mode" do
               @disk.mode.should == 'w'
             end
           end
         end
       end
     end
   end
end