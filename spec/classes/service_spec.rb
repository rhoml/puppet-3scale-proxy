# spec/classes/init_spec.pp

require 'spec_helper'

describe "nginx" do
  let(:openresty_path) { '/opt/openresty' }
  let(:provider_id) { '48' }
  let(:prefix) { '/usr/src' }
  let(:openresty_version) { '1.2.3.8' }

  it do
    should contain_service('nginx').with(
      'ensure'    => 'running',
      'enable'    => true,
      'pattern'   => 'nginx',
      'hasstatus' => true,
      'hasrestart'=> true,
    )
  end
end
