define vosupport::enable_lcgdm_vo (
   $voname=$name,
   $unprivilegedmkgridmap=false,
   $gridservice="LFC"
)
{
   $vomappingdata = hiera_hash('vosupport::mappings',undef)
   $poolaccounts  = hiera_hash('vosupport::poolaccounts',undef)
   $vomsservers   = hiera_hash('vosupport::vomsservers',undef)
   $configfile    = "/etc/lcgdm-mkgridmap.conf"

   concat::fragment{"${voname}_lcgdmmkgridmapconf":
     target  => $configfile,
     order   => "08",
     content => template('vosupport/lcgdm-mkgridmap.conf.erb'),
   }

}

