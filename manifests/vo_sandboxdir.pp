class vosupport::vo_sandboxdir {

  if ! defined(File['/var/cream_sandbox']) {
    file{'/var/cream_sandbox':
      ensure => 'directory',
      owner => 'tomcat',
      group => 'tomcat',
      mode => 0775
    }
  }
  #
  # we only need the group ID here for each vo name
  # just loop over the mappings hash which has all the information which we need

  $mappings = hiera_hash('vosupport::mappings',undef)
  create_resources('vosupport::virtual_setupsandbox',$mappings)
}
