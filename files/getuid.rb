#!/usr/bin/env ruby
require 'rubygems'
require 'etc'
require 'yaml'
require 'net/ldap'

def populateFromLdap
  getUIDof = Hash.new()
  getUIDof["uid"] = Hash.new()
  getUIDof["gid"] = Hash.new()
  ldap = Net::LDAP.new
  ldap.host = "xldap.cern.ch"
  ldap.port = "389"
  
  is_authorized = ldap.bind
  filter = "displayname = *Grid-User*"
  attrs = ["name", "uidNumber", "gidNumber", "displayName"]
  ldap.search( :base => "ou=Users,ou=Organic Units,dc=cern,dc=ch", :attributes => attrs, :filter => filter, :return_result => true ) do |entry|
    name = ""
    uid  = ""
    gid  = ""
    entry.attribute_names.each do |n|
      case "#{n}"
      when "name"
        name = "#{entry[n]}"
      when "uidnumber"
        uid = "#{entry[n]}"
      when "gidnumber"
        gid = "#{entry[n]}"
      end
    end
    getUIDof["uid"][name] = uid.to_s()
    getUIDof["gid"][name] = gid.to_s() 
  end  
  return getUIDof
end

cachedir = '/var/cache/poolaccounts'
cachefile = cachedir + '/uids.yaml'
newcache  = cachefile + '.new'
getUIDof = populateFromLdap()
File.open(newcache,"w") do |f|
  YAML.dump(getUIDof, f)
end
if (File.size?(newcache))
  File.rename(newcache,cachefile)
end
