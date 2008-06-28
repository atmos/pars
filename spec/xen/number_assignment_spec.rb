require File.dirname(__FILE__) + '/../spec_helper'

describe XenConfigFileYouShouldntUse::AssignmentNode do
  before(:all) do
    @parser = Pars::Xen::Parser.new
  end
  it "should not be nil" do
    @parser.should_not be_nil
  end
  describe " calling .parse" do
    describe "with a single quoted string" do
      before(:all) do
        @result = @parser.parse("name = 348\n")
      end
      it "should return a parse representation of the assignment" do
        @result.should_not be_nil
      end
      it "should return an assignment node you shouldn't use" do
        @result.should be_a_kind_of(XenConfigFileYouShouldntUse::AssignmentNode)
      end
      describe " calling .eval" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return the value of the assignment" do
          @evaluated_result.should == 348
        end
      end
    end
  end
end