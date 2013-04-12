#enables vosupport features (accounts, mappings, environment)
define vosupport::enable_vo (
   $voname=$name,
   $enable_poolaccounts = true,
   $enable_mappings_for_service = undef,
   $enable_environment = true,
   $enable_voms = true
)
{    
    if ($enable_voms) {
      #lookup table for VO names in voms module, when the name of the voms module is different from the VO name
      $voms_module_name= $voname? {
         'envirogrids.vo.eu-egee.org' => "envirogrids",
         'testers.eu-emi.eu' => "emitesters",
         'testers2.eu-emi.eu'=> "emitesters",
         'vo.gear.cern.ch' => 'gear',
         'vo.l3.cern.ch' => 'l3',
         'vo.opal.cern.ch' => 'opal',
         'vo.sixt.cern.ch' => 'sixt',
         'prod.vo.eu-eela.eu' => 'eela',
         'vo.delphi.cern.ch' => 'delphi', 
         'vo.aleph.cern.ch' => 'aleph',
        default => $voname
      }
      include "voms::${voms_module_name}"      
    }
    
    if ($enable_poolaccounts) {
      include vosupport::vo_poolaccounts      
      Setuphome <| voname == $voname |>
    }
    
    if ($enable_environment) {
      include vosupport::vo_environment
      Voenv  <| voname == $voname |>
    }
    
    if $enable_mappings_for_service != undef {
      include vosupport::vo_mappings
      
      #create file fragments for the specified VO and service
      $vomappingdata = hiera_hash('vosupport::mappings',undef)
      
      concat::fragment{"${voname}_mapfile": 
	target  => "/etc/grid-security/grid-mapfile",
	order   => "9",
	content => template('vosupport/gridmapfile.erb'),
      }
      
      concat::fragment{"${voname}_vomsmapfile": 
        target  => "/etc/grid-security/voms-grid-mapfile",
        order   => "9",
        content => template('vosupport/gridmapfile.erb')
      }
      
      concat::fragment{"${voname}_groupmapfile": 
	target  => "/etc/grid-security/groupmapfile",
	order   => "9",
	content => template('vosupport/groupmapfile.erb')
      }    
    }
}


