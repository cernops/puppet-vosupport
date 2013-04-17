Puppet::Type.type(:poolhome).provide(:poolhome) do
  desc "ensure that pool home directories are present"
  
  def create
    expand(resource[:start],resource[:number],resource[:prefix],resource[:digits]).each { |accountname|
      homedir = resource[:homeroot] + '/' + accountname
      if (! File.directory?(homedir) ) 
        uid = getUID(accountname)
        gid = getGID(accountname)
        if (uid > 0 && gid > 0)
          Dir.mkdir(homedir,0750)
          File.chown(uid,gid,homedir)
        else
          fail("Cannot create directory")
        end
      end 
    }
  end
  
  def getUID(name)
    poolUidGids = resource[:uidmap]
    lookup = poolUidGids["uid"][name]
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
    if (lookup && lookup.to_i > 0)
      gid = lookup.to_i()
    else 
      if (resource[:defaultgid] && resource[:defaultgid].to_i > 0 ) 
        gid = resource[:defaultgid].to_i
      else
        gid = 0
      end
    end
    return gid
  end
  
  def destroy
    # we don't destroy the home directories again ...
  end
  
  def exists?
    exists = true
    expand(resource[:start],resource[:number],resource[:prefix],resource[:digits]).each { |accountname|
      homedir = resource[:homeroot] + '/' + accountname
      if (File.exists?(homedir) && File.directory?(homedir))
        # ensure that the permissions are correct. This is needed for glExec to work
        if (sprintf("%o", File.stat(homedir).mode) != "40750")
          notice "Warning: \"" + homedir+ "\" has wrong permission settings. Correcting them to 0750\n"
          File.chmod(0750,homedir)
        end
      else 
        exists = false
      end
    }
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
