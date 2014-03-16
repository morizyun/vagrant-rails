versions = "5.6.16-1.el6.x86_64"
default['mysql']['versions']   = versions
default['mysql']['file_name']  = "MySQL-#{versions}.rpm-bundle.tar"
default['mysql']['remote_uri'] = "http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.6/MySQL-#{versions}.rpm-bundle.tar"
default['mysql']['rpm'] = [
  {
    :rpm_file     => "MySQL-server-#{versions}.rpm",
    :package_name => "MySQL-server"
  },
  {
    :rpm_file     => "MySQL-client-#{versions}.rpm",
    :package_name => "MySQL-client"
  },
  {
    :rpm_file     => "MySQL-devel-#{versions}.rpm",
    :package_name => "MySQL-devel"
  },
  {
    :rpm_file     => "MySQL-shared-#{versions}.rpm",
    :package_name => "MySQL-shared"
  }
]