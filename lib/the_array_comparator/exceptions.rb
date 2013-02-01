module TheArrayComparator
  module Exceptions 
    # Used when one tries to add an unknown 
    # probe type to check for
    class UnknownProbeType < Exception
    end

    # Used if one tries to register an
    # incompatible comparator
    class IncompatibleComparator < Exception
    end

    # Used if one tries to delete an
    # unexisting probe
    class ProbeDoesNotExist < Exception
    end
  end
end
