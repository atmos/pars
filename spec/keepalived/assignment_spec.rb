require File.dirname(__FILE__) + '/../spec_helper'

describe KeepAlivedConfigFileYouShouldntUse::AssignmentNode, "variable assignment in keepalived.conf" do
  before(:all) do
    @parser = Pars::KeepAlived::Parser.new
  end
  it "should not be nil" do
    @parser.should_not be_nil
  end
  require File.dirname(__FILE__) + '/../spec_helper'

  describe ".parse" do
    require File.dirname(__FILE__) + '/../spec_helper'

    describe "with one parameter" do
      before(:all) do
        @result = @parser.parse("lvs_sync_daemon_interface internal\n")
        # pp @result
      end
      it "should return a parse representation of the assignment" do
        @result.should_not be_nil
      end
      it "should return a config file you shouldn't use" do
        @result.should be_a_kind_of(KeepAlivedConfigFileYouShouldntUse::ConfigFile)
      end
      describe ".eval" do
        before(:all) do
          @evaluated_result = @result.eval({})
          pp @evaluated_result
        end
        it "should return the value of the assignment" do
          @evaluated_result[:lvs_sync_daemon_interface].should == 'internal'
        end
      end
    end
  end
end