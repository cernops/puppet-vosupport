class vosupport::vo_sudoers {
  $poolaccounts = hiera_hash('vosupport::poolaccounts',undef)
  create_resources('vosupport::virtual_setupsudoers',$poolaccounts)
}
