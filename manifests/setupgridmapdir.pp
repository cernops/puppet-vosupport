define vosupport::setupgridmapdir (
  $prefix=$name,
  $number,
  $start=1,
  $digits=3,
  $gridmapdir='/etc/grid-security/gridmapdir',
  $voname='',
)
{
      gridmapdirentry {$prefix:
        ensure => present,
        number => $number,
        start  => $start,
        digits => $digits,
        gridmapdir => $gridmapdir,
        require => File[$gridmapdir],
      }
}

