#initialize VO gridmapdir virtual resources
class vosupport::vo_gridmapdir()
{
  
  $poolaccounts = hiera_hash('vosupport::poolaccounts',undef)
  create_resources('vosupport::virtual_setupgridmapdir',$poolaccounts, {gridmapdir => '/etc/grid-security/gridmapdir'})
}
