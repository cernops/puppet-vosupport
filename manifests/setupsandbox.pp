define vosupport::setupsandbox (
  $prefix=$name,
  $group='',
  $voname='',
)
{
  if ! defined(File["/var/cream_sandbox/$group"]) {
    file{"/var/cream_sandbox/$group": 
      ensure => 'directory',
      owner => 'tomcat',
      group => $group,
      mode => '0770',
    }  
  }
}

