#
#
#
module Puppet::Parser::Functions
  newfunction(:uidfilterbygid, :type => :rvalue, :doc =><<-EOS
This function queries the password file and filters for grid pool accounts.
it returns a two dimensional hash containing uids and gids for these accounts

EOS
              ) do |args|
    uidmap=args[0]
    gid=args[1]
    
    filtered = Hash.new()
    filtered["uid"] = Hash.new()
    filtered["gid"] = Hash.new()
    
    uidmap["uid"].each { |key, value|
      thisgid = uidmap["gid"][key]
      if  thisgid == gid.to_s
        filtered["uid"][key] = value
        # to be removed later once the additional defaultgid parameter works
        # filtered["gid"][key] = gid
      end
    }
    return filtered
  end
end
