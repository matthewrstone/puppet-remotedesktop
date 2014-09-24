require 'spec_helper'
describe 'remotedesktop' do

  context 'with defaults for all parameters' do
    it { should contain_class('remotedesktop') }
  end
end
