Puppet::Type.newtype(:gridmapdirentry) do 
  @doc = "ensures that file entries for pool accounts are present in gridmapdir"
  ensurable
  
  newparam(:prefix) do 
    desc "account prefix"
    validate do |value|
      unless  value =~ /^[a-zA-Z]+/
        raise ArgumentError , "%s invalid prefix name" % value
      end
    end
    isnamevar
  end

  newparam(:number) do 
    desc "number of pool accounts to be created"
    defaultto 10
    validate do |value|
      unless  value.to_s =~ /^[\d]+/
        raise ArgumentError , "number of pool accounts must be an integer: \"%s\"" % value
      end
    end
  end
  

  newparam(:start) do 
    desc "first number to start with"
    defaultto "1"
    validate do |value|
      unless  value.to_s =~ /^[\d]+$/
        raise ArgumentError , "\"%s\" first number must be an integer" % value
      end
    end
  end

  newparam(:digits) do 
    desc "number of digits"
    defaultto "3"
    validate do |value|
      unless  value.to_s =~ /^[\d]$/
        raise ArgumentError , "\"%s\" number of digits must be an integer" % value
      end
    end
  end

  newparam(:gridmapdir) do 
    desc "path to the gridmapdir"
    defaultto "/etc/grid-security/gridmapdir"
    validate do |value|
      unless  value =~ /^\//
        raise ArgumentError , "\"%s\" must be a valid absolute path" % value
      end
    end
  end
  
  autorequire(:file) do
  	[ self[:gridmapdir] ]
  end

end

