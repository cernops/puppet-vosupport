define vosupport::voenv (
  $voshortname = $name,
  $vo_default_se = 'unset',
  $vo_sw_dir = 'unset',
  $voname,
)
{
  concat::fragment{"env_${voshortname}": 
    target  => '/etc/profile.d/grid-vo-env.sh',
    order   => '55',
    content => template('vosupport/gridenv-vo.sh.erb')
  }  
}
