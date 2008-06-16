require File.dirname(__FILE__) + "/../spec_helper"

describe Pars::NginxConfig::AST::Server, "server { ... }" do
  before(:all) do
    @parser = Pars::NginxConfig::Parser.new
  end
  describe "defining server block" do
    before(:all) do
      @result = @parser.parse(fixture("nginx/server.conf"))
      # pp @parser
    end
    it "should return a parsed object" do
      @result.should_not be_nil
    end
    describe "evaluating the result" do
      before(:all) do
        @evaluated_result = @result.eval({})[:servers].first
        # pp @evaluated_result
      end
      # TODO: account for both specified host and implicit
      it "should set port to 80" do
        @evaluated_result.vars[:listen].should eql(80)
      end
      it "should set the port to '0.0.0.0'" do
        @evaluated_result.vars[:host].should eql("0.0.0.0")
      end

      it "should set access_log location to '/var/log/engineyard/nginx/access.log' and level to 'main'" # do
       #        @evaluated_result.access_log.location.should eql("/var/log/engineyard/nginx/access.log")
       #        @evaluated_result.access_log.level.should eql("main")
       #      end
      it "should set error_log location to '/var/log/nginx.application.error.log' and level to 'notice'" # do
       #        @evaluated_result.error_log.location.should eql("/dev/null")
       #        @evaluated_result.error_log.level.should eql("notice")
       #      end
      it "should set sendfile to 'on'" # do
       #        @evaluated_result.sendfile.should eql("on")
       #      end
      it "should set tcp_nopush to 'on'" # do
       #        @evaluated_result.tcp_nopush.should eql("on")
       #      end
      it "should set tcp_nodelay to 'on'" # do
       #        @evaluated_result.tcp_nodelay.should eql("on")
       #      end
      it "should set gzip to 'on'" # do
       #        @evaluated_result.gzip.should eql("on")
       #      end
      it "should set gzip_http_version to '1.0'" # do
       #        @evaluated_result.gzip_http_version.should eql("1.0")
       #      end
      it "should set gzip_comp_level to 'gzip_proxied'" # do
       #        @evaluated_result.gzip_comp_level.should eql("gzip_proxied")
       #      end

      # TODO: dig deeper into the buffer size definition by splitting it
      it "should set gzip_buffers to '16 8k'" # do
       #        @evaluated_result.gzip_buffers.should eql("16 8k")
       #      end
      
      # TODO: replace gzip_types with an array
      it "should set gzip_types to 'text/plain text/html text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript'" # do
       #        @evaluated_result.gzip_types.should eql("text/plain text/html text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript")
       #      end
      it "should set gzip_disable to 'MSIE [1-6]\.'" # do
       #        @evaluated_result.gzip_disable.should eql("MSIE [1-6]\\.")
       #      end
    end
  end
end