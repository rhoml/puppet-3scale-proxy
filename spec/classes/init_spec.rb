# spec/classes/init_spec.pp

require 'spec_helper'

describe "nginx" do
  let(:openresty_path) { '/opt/openresty' }
  let(:provider_id) { '48' }

  it do
    should include_class('nginx::dependencies') 
  end

  it do
    should include_class('nginx::install') 
  end

  it do
     should include_class('nginx::service') 
  end

  it do
    should contain_file("#{openresty_path}/nginx/conf/nginx.conf").with({
      'ensure'  => 'present',
      'owner'   => 'nginx',
      'group'   => 'nginx',
      'mode'    => '0644' 
    })
  end

  it do
    should contain_file("#{openresty_path}/nginx/conf/nginx_#{provider_id}.lua").with({
      'ensure' => 'present',
      'mode'   => '0644',
      'owner'  => 'nginx',
      'group'  => 'nginx'
    })
  end

  it do
    should contain_file('/etc/init.d/nginx').with({
      'ensure' => 'present',
      'mode'   => '0755',
    })
  end

  it do
    should contain_file('/etc/init.d/nginx').with_content(/DAEMON=#{openresty_path}/)
  end

end
