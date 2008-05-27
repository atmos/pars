require File.dirname(__FILE__) + '/../spec_helper'

describe Xm::ListOutput, "parsing output" do
  before(:all) do
    @parser = Xm::ListOutput.new
  end
  describe "parsing a file" do
    before(:all) do
      @result = @parser.parse(File.dirname(__FILE__)+'/../fixtures/xm/list/ey00n00.xm.list.txt')
    end
    it "should return an array of hashes entries" do
      @result.should be_a_kind_of(Array)
      @result.each do |line|
        line.should be_a_kind_of(Hash)
      end
    end
    it "should have an element for each xen instance" do
      @result.should have(17).entries
    end
  end
end