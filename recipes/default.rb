require 'chef/util/file_edit'

package 'tzdata' unless platform? %w{gentoo}

link '/etc/localtime' do
  filename = "/usr/share/zoneinfo/#{node['timezone']}"
  to filename
  only_if do
    check = File.exists? filename
    raise "timezone #{node['timezone']} does not exist" unless check
    check
  end
end

if platform? %w{ubuntu debian}
  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code '/usr/sbin/dpkg-reconfigure -f noninteractive tzdata'
  end
elsif platform? %w{redhat centos scientific amazon}
  clock = Chef::Util::FileEdit.new("/etc/sysconfig/clock")
  clock.search_file_replace_line(/^ZONE=.*$/, "ZONE=\"#{node['timezone']}\"")
  clock.write_file
end
