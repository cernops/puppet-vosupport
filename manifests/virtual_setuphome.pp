define vosupport::virtual_setuphome (
  $prefix=$name,
  $number,
  $start=1,
  $digits=3,
  $homeroot='/pool/grid',
  $voname='',
  $uids=undef,
)
{
  #notice("Loading account data for ${voname}")
  @vosupport::setuphome{$name:
    number   => $number,
    start    => $start,
    digits   => $digits,
    homeroot => $homeroot,
    voname => $voname,
    uids => $uids,
  }
}
