#
#
#
module Puppet::Parser::Functions
  newfunction(:expandpoollist, :type => :rvalue, :doc =><<-EOS
This function returns the expanded list of pool accounts. Use with care ...

EOS
              ) do |args|
    from=args[0]
    number=args[1]
    prefix=args[2]
    digits=args[3]
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
