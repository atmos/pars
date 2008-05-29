require File.dirname(__FILE__) + '/../spec_helper'

describe KeepAlivedConfigFileYouShouldntUse::CommentNode do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  it "should not be nil" do
    @parser.should_not be_nil
  end
  
  describe " calling .parse" do
    describe "with a comment line beginning with !" do
      before(:all) do
        @result = @parser.parse("! zomg comment\n")
      end
      it "should return a parse representation of the assignment" do
        @result.should_not be_nil
      end
      it "should return a config file you shouldn't use" do
        @result.should be_a_kind_of(KeepAlivedConfigFileYouShouldntUse::ConfigFile)
      end
      describe " calling .eval" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return the value of the assignment" do
          @evaluated_result.should == {}
        end
      end
    end
    describe "with a multiline comment beginning with #" do
      before(:all) do
        @result = @parser.parse("# zomg comment\n# zomg comment\n#zomg comment\n")
      end
      it "should return a parse representation of the assignment" do
        @result.should_not be_nil
      end
      it "should return a config file you shouldn't use" do
        @result.should be_a_kind_of(KeepAlivedConfigFileYouShouldntUse::ConfigFile)
      end
      describe " calling .eval" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return the value of the assignment" do
          @evaluated_result.should == {}
        end
      end
    end
    
  end
end