require_relative "../spec_helper.rb"
require 'helper_methods'

describe "HelperMethods" do

  let(:node) { {} }
  let(:chef) {
    chef_class = Class.new {
      include OpsworksBashrc::HelperMethods
      attr_accessor :node
    }
    chef_class.new.tap {|c| c.node = node}
  }

  describe "#app_name" do
    context "with node[:appname] defined" do
      let(:node) { {:appname => "herp_derp"} }

      it "returns the value of node[:appname]" do
        expect(chef.app_name).to eq "herp_derp"
      end
    end

    context "with node[:opsworks][:applications].first['slug_name'] defined" do
      let(:node) { {:opsworks => {:applications => [{'slug_name' => "herp_derp"}] } } }

      it "returns the value of node[:app_name]" do
        expect(chef.app_name).to eq "herp_derp"
      end
    end

    context "with neither defined" do
      it "returns nil" do
        expect(chef.app_name).to be_nil
      end
    end
  end

  describe "#app_dir" do
    context "with node[:appdir] defined" do
      let(:node) { {:appdir => "/foo/bar/baz"} }

      it "returns the value of node[:appdir]" do
        expect(chef.app_dir).to eq "/foo/bar/baz"
      end
    end

    context "with node[:deploy][app_name][:deploy_to] defined" do
      let(:node) { {:deploy => {'herp_derp' => {:deploy_to => "/foo/bar/baz"} } } }
      before { allow(chef).to receive(:app_name).and_return('herp_derp') }

      it "returns the value of node[:deploy][app_name][:deploy_to]" do
        expect(chef.app_dir).to eq "/foo/bar/baz"
      end
    end

    context "with node[:opsworks][:deploy][app_name][:deploy_to] defined" do
      let(:node) { {:opsworks => {:deploy => {'herp_derp' => {:deploy_to => "/foo/bar/baz"} } } } }
      before { allow(chef).to receive(:app_name).and_return('herp_derp') }

      it "returns the value of node[:opsworks][:deploy][app_name][:deploy_to]" do
        expect(chef.app_dir).to eq "/foo/bar/baz"
      end
    end
  end

end
