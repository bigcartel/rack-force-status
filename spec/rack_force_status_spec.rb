require 'spec_helper'

describe Rack::ForceStatus do
  let(:body) { '<html><body><h1>Hi</h1></body></html>' }
  let(:original_status) { 422 }
  let(:custom_param) { nil }
  let(:custom_header) { nil }
  let(:options) { { :param => custom_param, :header => custom_header }}
  let(:app) { lambda { |env| [original_status, {}, [body]] } }
  let(:request) { Rack::MockRequest.env_for("/", :params => "foo=bar&#{ custom_param || 'force_status' }=#{ forced_status }") }
  let(:response) { Rack::ForceStatus.new(app, options).call(request) }
  
  describe "when we want to force the status" do
    let(:forced_status) { 200 }
    
    it "should force the status code" do
      response[0].should == forced_status
    end
    
    it "should add a header with the original status code" do
      response[1]['X-Original-Status-Code'].should == original_status.to_s
    end
    
    it "shouldn't effect the body" do
      response[2].should == [body]
    end
  end
  
  describe "when we've customized the middleware" do
    let(:forced_status) { 200 }
    let(:custom_param) { 'my-param' }
    let(:custom_header) { 'my-header' }
    
    it "should force the status code" do
      response[0].should == forced_status
    end
    
    it "should add a header with the original status code" do
      response[1][custom_header].should == original_status.to_s
    end
    
    it "shouldn't effect the body" do
      response[2].should == [body]
    end
  end
  
  describe "when we don't want to force the status" do
    let(:forced_status) { nil }
    
    it "should maintain the original code" do
      response[0].should == original_status
    end
    
    it "should not add a header with the original status code" do
      response[1]['X-Original-Status-Code'].should be_nil
    end
    
    it "shouldn't effect the body" do
      response[2].should == [body]
    end
  end
end
