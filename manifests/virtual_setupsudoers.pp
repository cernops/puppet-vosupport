define vosupport::virtual_setupsudoers (
  $prefix=$name,
  $number,
  $start=1,
  $digits=3,
  $voname='',
)
{
  @vosupport::setupsudoers {$name:
    prefix => $prefix,
    number => $number,
    start  => $start,
    digits => $digits,
    voname => $voname,
  }
}
