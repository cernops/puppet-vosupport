#initialize VO mapping resources
class vosupport::vo_mappings()
{

  concat{'/etc/grid-security/grid-mapfile':
    owner =>  'root',
    group =>  'root',
    mode  =>  '0644',
    warn => "# File managed by Puppet module vosupport",         
  }

  concat{'/etc/grid-security/voms-grid-mapfile':
    owner =>  'root',
    group =>  'root',
    mode  =>  '0644',
    warn => "# File managed by Puppet module vosupport",         
  }
  
  concat{'/etc/grid-security/groupmapfile':
    owner =>  'root',
    group =>  'root',
    mode  =>  '0644',
    warn => "# File managed by Puppet module vosupport",         
  }

}
