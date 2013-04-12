class vosupport::uidmap {
  $uidmap    = getuids([])
  $vo2gidmap = hiera("vo2gidmap", undef)
}
