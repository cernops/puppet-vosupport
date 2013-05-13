Puppet::Type.type(:gridmapdirentry).provide(:gridmapdirentry) do
  desc "ensures that file entries for pool accounts are present in gridmapdir"
  
  def create
    expand(resource[:start],resource[:number],resource[:prefix],resource[:digits]).each { |accountname|
      path = resource[:gridmapdir] + '/' + accountname
      if (! File.exist?(path) ) 
        File.open(path,"w",0644){} #create empty file
      end 
    }
  end
    
  def destroy
    expand(resource[:start],resource[:number],resource[:prefix],resource[:digits]).each { |accountname|
      path = resource[:gridmapdir] + '/' + accountname
      if (File.exist?(path) ) 
        File.delete(path)
      end 
    }
  end
  
  def exists?
    allexist = true
    expand(resource[:start],resource[:number],resource[:prefix],resource[:digits]).each { |accountname|
      path = resource[:gridmapdir] + '/' + accountname
      if (! File.exists?(path))
        allexist = false
      end
    }
    return allexist
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
