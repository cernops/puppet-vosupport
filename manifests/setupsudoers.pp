define vosupport::setupsudoers (
  $prefix=$name,
  $number,
  $start=1,
  $digits=3,
  $voname='',
)
{
  $list=expandpoollist($start,$number,$prefix,$digits)
  file{"/etc/sudoers.d/glexec_${prefix}": 
    content => template('vosupport/sudoers_forcecream.erb'),
    ensure => present,
    owner => "root",
    group => "root",
    mode => 0640,
  }  
}

