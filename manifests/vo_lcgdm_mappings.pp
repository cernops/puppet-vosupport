#initialize VO LCGDM mapping resources
class vosupport::vo_lcgdm_mappings(
   $configfile   = "/etc/lcgdm-mkgridmap.conf",
   $mapfile      = "/etc/lcgdm-mapfile",
   $localmapfile = "/etc/lcgdm-mapfile-local",
   $logfile      = "/var/log/lcgdm-mkgridmap.log"
)
{
   concat{$configfile:
     owner =>  'root',
     group =>  'root',
     mode  =>  '0644',
     warn => "# File managed by Puppet module vosupport",
   }
   concat::fragment{'lcgdmmkgridmapconf footer':
     target  => $configfile,
     order   => '99',
     content => template('vosupport/lcgdm-mkgridmap.conf_footer.erb')
   }
   file{
     "$mapfile":
      ensure => present,
      owner  => root,
      group  => root,
      mode   => '0644';
     "$localmapfile":
      ensure => present,
      owner  => root,
      group  => root,
      mode   => '0644'
   }

   # for edg-mkgridmap   
   package {"edg-mkgridmap": 
    ensure => present,
    require => Class["emirepos::emirepositories"]
     }

   cron {"${configfile}-cron":
    command => "(date; /usr/libexec/edg-mkgridmap/edg-mkgridmap.pl --conf=$configfile --output=$mapfile --safe) >> $logfile 2>&1",
    environment => "PATH=/sbin:/bin:/usr/sbin:/usr/bin",
    user        => root,
    hour        => [5,11,18,23],
    minute      => 55,
    require     => [Concat[$configfile], Package['edg-mkgridmap']]
  }
}

