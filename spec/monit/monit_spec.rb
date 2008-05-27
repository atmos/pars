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
    it "should have return a hash of services" do
      @result.services.should be_a_kind_of(Hash)
    end
  end
end