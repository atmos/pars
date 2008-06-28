require File.dirname(__FILE__) + '/../spec_helper'

describe XenConfigFile::AST::ConfigFile do
  before(:all) do
    
  end
end

describe XenConfigFile::AST::Disk do
  describe "initialize" do
    before(:all) do
      @disk = XenConfigFile::AST::Disk.new('phy:/dev/ey00-data4/root-s00348', 'sda1', 'w')
    end
    it "should create successfully" do
      @disk.should_not be_nil
    end
    it "should assign the volume" do
      @disk.volume.should == 'phy:/dev/ey00-data4/root-s00348'
    end
    it "should assign the device" do
      @disk.device.should == 'sda1'
    end
    it "should assign the mode" do
      @disk.mode.should == 'w'
    end
    it "should handle writing itself out" do
      @disk.to_s.should == 'phy:/dev/ey00-data4/root-s00348,sda1,w'
    end
  end
  
  describe "build" do
    before(:all) do
      @params = ["phy:/dev/ey00-data4/root-s00348,sda1,w", "phy:/dev/ey00-data4/swap-s00348,sda2,w", "phy:/dev/ey00-data4/gfs-00218,sdb1,w!"]
      @disks = XenConfigFile::AST::Disk.build(XenConfigFile::AST::ArrayAssignment.new(:disk, @params))
    end
    it "should build successfully" do
      @disks.should_not be_nil
    end
    it "should have three elements" do
      @disks.should have(3).entries
    end
  end
end