# spec/classes/init_spec.pp

require 'spec_helper'

describe "nginx" do
  let(:openresty_path) { '/opt/openresty' }
  let(:provider_id) { '48' }
  let(:prefix) { '/usr/src' }
  let(:openresty_version) { '1.2.3.8' }

  it do
    should contain_file("#{prefix}").with({
      'ensure' => 'directory',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0755',
    })
  end

  it do
    should contain_group('nginx').with(
      'gid' => '1200'
    )
  end

  it do
    should contain_user('nginx').with(
      'ensure'  => 'present',
      'comment' => 'Nginx system user',
      'uid'     => '1200',
      'gid'     => '1200',
      'shell'   => '/bin/false',
      'groups'  => 'nginx',
      'system'  => true,
    )
  end

  it do
    should contain_file("#{prefix}/ngx_openresty-#{openresty_version}.tar.gz").with({
      'ensure' => 'present',
      'owner'  => 'nginx',
      'group'  => 'nginx',
    })
  end

  it do
    should contain_exec("tar xzf ngx_openresty-#{openresty_version}.tar.gz").with(
      'subscribe' => 'File[nginx-source-tgz]',
      'creates'   => "#{prefix}/ngx_openresty-#{openresty_version}",
      'alias'     => 'untar-nginx-source',
      'cwd'       => "#{prefix}",
    )
  end

  it do
    should contain_exec("/bin/ls | ./configure --prefix=#{openresty_path} --with-luajit --with-http_iconv_module -j2 && touch #{prefix}/ngx_openresty-#{openresty_version}/.config").with(
    'cwd'     => "#{prefix}/ngx_openresty-#{openresty_version}",
    'creates' => "#{prefix}/ngx_openresty-#{openresty_version}/.config",
    'alias'   => 'configure-nginx',
    'before'  => 'Exec[make-install]',
    )
  end

  it do
    should contain_exec('make && make install').with(
      'cwd'     => "/usr/src/ngx_openresty-#{openresty_version}",
      'alias'   => 'make-install',
      'creates' => '/opt/openresty/nginx/sbin/nginx',
      'require' => 'Exec[configure-nginx]',
    )
  end
end
