define vosupport::virtual_voenv (
  $voshortname = $name,
  $vo_default_se = 'unset',
  $vo_sw_dir = 'unset',
  $voname = $name,
)
{
  @vosupport::voenv{"env_${voshortname}":
    vo_sw_dir => $vo_sw_dir,
    vo_default_se => $vo_default_se,
    voname => $voname,
  }
}
