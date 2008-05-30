require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::KeepAlived::Parser, "parsing" do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  
  describe "keepalived.conf as input" do
    before(:all) do
      @result = @parser.parse(File.read(File.dirname(__FILE__)+'/../fixtures/keepalived/keepalived.conf'))
      # pp @parser
      # raise ArgumentError
    end
    it "shouldn't be nil" do
      @result.should_not be_nil
    end
    it "should return a kind of KeepAlivedConfigFileYouShouldntUse::ConfigFile" do
      @result.should be_a_kind_of(KeepAlivedConfigFileYouShouldntUse::ConfigFile)
    end

    describe "evaluated output" do
      before(:all) do
        @evaluated_result = @result.eval
        # pp @evaluated_result
      end
      it "should return a hash of the evaluated string" do
        @evaluated_result.should be_a_kind_of(Hash)          
      end
    end
  end
end