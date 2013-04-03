#initialize VO poolaccount virtual resources
class vosupport::vo_poolaccounts()
{
  package {'rubygem-ruby-net-ldap':
    ensure => present,
  }
  
  #
  # we need to assume that /pool is already there
  #
  
  file {
    "/home":
      ensure => directory,
      owner   => root,
      group   => root,
      mode    => 0755,
  }
  
  file {
    "/pool/grid":
      # require => File['/pool'],
      ensure => directory,
      owner   => root,
      group   => root,
      mode    => 0755,
  }
  
  file {"/home/grid":
    ensure  => link,
    target => "/pool/grid"
  }

  $uidmap = getuids([])
  $poolaccounts = hiera_hash('vosupport::poolaccounts',undef)
  create_resources('vosupport::virtual_setuphome',$poolaccounts,{uids=>$uids})
}
