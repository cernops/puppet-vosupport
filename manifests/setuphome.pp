define vosupport::setuphome (
  $prefix=$name,
  $number,
  $start=1,
  $digits=3,
  $homeroot='/pool/grid',
  $voname='',
)
{
  if ($prefix){
    if ($vosupport::uidmap::vo2gidmap){
      $gid = $vosupport::uidmap::vo2gidmap[$voname]
      poolhome {$prefix:
        ensure => present,
        number => $number,
        start  => $start,
        digits => $digits,
        homeroot => $homeroot,
        uidmap => uidfilterbygid($vosupport::uidmap::uidmap,$gid),
        # defaultgid => $gid,
        require => File[$homeroot],
      }
    }
    else
    {
      poolhome {$prefix:
        ensure => present,
        number => $number,
        start  => $start,
        digits => $digits,
        homeroot => $homeroot,
        uidmap => $vosupport::uidmap::uidmap,
        require => File[$homeroot],
      }
    }
  }
}
