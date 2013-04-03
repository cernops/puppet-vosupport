Puppet::Type.type(:poolhome).provide(:poolhome) do
  desc "ensure that pool home directories are present"
  
  def create
    expand(resource[:start],resource[:number],resource[:prefix],resource[:digits]).each { |accountname|
      homedir = resource[:homeroot] + '/' + accountname
      #notice("Creating "+homedir)
      if (! File.directory?(homedir) ) 
        uid = getUID(accountname)
        gid = getGID(accountname)
        if (uid > 0 && gid > 0)
          Dir.mkdir(homedir,0700)
          File.chown(uid,gid,homedir)
          #notice("created "+homedir+" with uid="+uid.to_s()+" and gid="+gid.to_s())
        else
          fail("Cannot create directory")
        end
      end 
    }
  end
  
  def getUID(name)
    poolUidGids = resource[:uidmap]
    lookup = poolUidGids["uid"][name]
    #notice(lookup)
    if (lookup != "") 
      uid = lookup.to_i()
    else 
      uid = 0
    end
    return uid
  end
  
  def getGID(name)
    poolUidGids = resource[:uidmap]
    lookup = poolUidGids["gid"][name]
    #notice(lookup)
    if (lookup != "")
      gid = lookup.to_i()
    else 
      gid = 0
    end
    return gid
  end
  
  def destroy
    # we don't destroy the home directories again ...
  end
  
  def exists?
    #notice("checking pool accounts")
    exists = true
    expand(resource[:start],resource[:number],resource[:prefix],resource[:digits]).each { |accountname|
      homedir = resource[:homeroot] + '/' + accountname
      if (! File.directory?(homedir) )
        #notice("Directory "+homedir+" is missing")
        exists = false
      end
    }
    #if (exists)
    #  notice("All home directories exist")
    #else
    #  notice("Some pool account home directories are missing. Will try to create them.")
    #end
    return exists
  end
  
  def expand(from,number,prefix,digits)
    expanded = []
    if ("0" == digits.to_s) 
      expanded.push(prefix)
    else
      (from.to_s.to_i() .. (from.to_s.to_i()+number.to_s.to_i()-1)).each { |c|
        format = '%.'+digits.to_s()+'d'
        name=prefix + (format % c).to_s()
        expanded.push(name)
      }
    end
    return expanded
  end
  
end
