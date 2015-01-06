require 'spec_helper'

describe 'tmux::default' do

  context 'using default attributes' do
    let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
    it 'installs package' do
      expect(chef_run).to install_package('tmux')
    end
    it 'creates config file' do
      expect(chef_run).to render_file('/etc/tmux.conf')
      expect(chef_run).to_not render_file('/etc/tmux.conf').with_content(/^set-option -g prefix .*$/)
      expect(chef_run).to_not render_file('/etc/tmux.conf').with_content(/^setw -g mode-keys vi$/)
      expect(chef_run).to render_file('/etc/tmux.conf').with_content('#(date +"%Y-%m-%d %H:%M")')
    end
  end

  context 'using custom attributes' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set[:tmux][:package] = 'tmux2'
        node.set[:tmux][:config_file] = '/tmp/tmux.conf'
        node.set[:tmux][:prefix_key] = 'C-a'
        node.set[:tmux][:vi_mode_keys] = true
        node.set[:tmux][:clock] = false
      end.converge(described_recipe)
    end
    it 'installs package' do
      expect(chef_run).to install_package('tmux2')
    end
    it 'creates a config file' do
      expect(chef_run).to render_file('/tmp/tmux.conf')
      expect(chef_run).to render_file('/tmp/tmux.conf').with_content(/^set-option -g prefix C-a$/)
      expect(chef_run).to render_file('/tmp/tmux.conf').with_content(/^setw -g mode-keys vi$/)
      expect(chef_run).to_not render_file('/tmp/tmux.conf').with_content('#(date +"%Y-%m-%d %H:%M")')
    end
  end

end #describe
