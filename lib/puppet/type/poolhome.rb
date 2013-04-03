Puppet::Type.newtype(:poolhome) do 
  @doc = "ensure that the home directory exists and is owned by the right account"
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

  newparam(:homeroot) do 
    desc "permissions of the secret"
    defaultto "/pool/grid"
    validate do |value|
      unless  value =~ /^\/[\/\w]+$/
        raise ArgumentError , "\"%s\" must be a valid absolute path" % value
      end
    end
  end

  newparam(:uidmap) do 
    desc "..."
    defaultto [ "uid" => ["cms001" => "123"],
                "gid" => ["cms001" => "234"], 
              ] 
  end
  
end
