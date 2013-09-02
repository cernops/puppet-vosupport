define vosupport::virtual_setupsandbox (
  $prefix=$name,
  $group='',
  $prefix='',
  $services='',
  $static='',
  $voname='',
)
{
  @vosupport::setupsandbox {$name:
    group => $group,
    voname => $voname,
  }
}
