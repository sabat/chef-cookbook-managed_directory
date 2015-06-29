#
# Cookbook Name:: managed_directory
# Spec:: test
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'managed_directory::test' do
  context 'When all attributes are default, on CentOS 6.6' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(
        step_into: ['managed_directory'],
        platform: 'centos',
        version: '6.6'
      ) do |node|
        # Set/override attributes here
      end
      runner.converge(described_recipe)
    end

    before do
      testdir_contents = [
        '/tmp/foo/a',
        '/tmp/foo/b',
        '/tmp/foo/c'
      ]
      allow(Dir).to receive(:glob).and_call_original
      allow(Dir).to receive(:glob).with('/tmp/foo/*').and_return(testdir_contents)
    end

    it 'should not remove file a' do
      expect(chef_run).to_not delete_file('/tmp/foo/a')
    end

    it 'should not remove file b' do
      expect(chef_run).to_not delete_file('/tmp/foo/b')
    end

    it 'should remove file c' do
      expect(chef_run).to delete_file('/tmp/foo/c')
    end
  end
end
