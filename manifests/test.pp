class vosupport::test {
  
  class {'vosupport':
    supported_vos => [atlas, cms, lhcb, alice, dteam, ops, 'vo.aleph.cern.ch', 'vo.delphi.cern.ch', 'vo.l3.cern.ch', 
                      'vo.opal.cern.ch', ilc, 'envirogrids.vo.eu-egee.org', geant4, na48, unosat, 'vo.gear.cern.ch',
                      'vo.sixt.cern.ch'], #prod.vo.eu-eela.eu: missing voms
  }
  #$supported_vos_hash=parseyaml(inline_template("{ <%= @supported_vos.collect{ |voname| voname + ': {}' }.join(', ') %>} "))  
  include vosupport::vo_poolaccounts      
  Setuphome <| voname == "vo.delphi.cern.ch" |>
}
