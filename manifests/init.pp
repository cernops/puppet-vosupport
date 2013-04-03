class vosupport(
  $supported_vos = hiera("vosupport_supported_vos",[]), #list of supported VOs we want to enable
  $enable_poolaccounts = hiera("vosupport_enable_poolaccounts",True), #whether to create pool accounts
  $enable_mappings_for_service = hiera("vosupport_enable_mappings_for_service",undef), #a service to enable mappings for (WMS, ARGUS...)
  $enable_environment = hiera("vosupport_enable_environment",True), #whether to set up the gridenv for these VOs
  $enable_voms = hiera("vosupport_enable_voms",True), #whether to enable VOMS client for these VOs
)  
{

  include concat::setup

  #
  # overall process: 
  #

  #get metadata from hiera
  #hash voname => { vohomedef => [ role definition array ] }
  #we want to create poolaccounts::setuphome for each role definition in the
  #VOs listed in $supported_vos

  #1. create virtual resources for each VO from hiera.
  #2. Each virtual resource will define a poolaccounts::setuphome for each role definition
  #3. we realize the VO resources that match $supported_vos

  #enable the list of supported VOs from the class parameters (most likely coming from hiera)
  #for create_resources to be happy we need to convert the  $supported_vos array into a hash
  #i.e. yaml that looks like "{ vo1: {}, vo2: {}, etc. }"
  $supported_vos_hash=parseyaml(inline_template("{ <%= @supported_vos.collect{ |voname| voname + ': {}' }.join(', ') %>} "))  
  
  $supported_vos_params={
    enable_poolaccounts => $enable_poolaccounts,
    enable_mappings_for_service => $enable_mappings_for_service,
    enable_environment => $enable_environment,
    enable_voms => $enable_voms
  }
  create_resources("vosupport::enable_vo", $supported_vos_hash, $supported_vos_params)
}
