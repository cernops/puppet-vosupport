define vosupport::setuphome (
  $prefix=$name,
  $number,
  $start=1,
  $digits=3,
  $homeroot='/pool/grid',
  $voname='',
  $uids=undef,
)
{
  #notice ($uids)
  if ($prefix){
    poolhome {$prefix:
      ensure => present,
      number => $number,
      start  => $start,
      digits => $digits,
      homeroot => $homeroot,
      uidmap => $uids,
      require => File[$homeroot],
    }
  }
}
