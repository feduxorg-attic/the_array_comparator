# the main module
module TheArrayComparator
  # exceptions which are going to be raised under
  # certain conditions
  module Exceptions 
    # Used when one tries to add an unknown 
    # probe type to check for
    class UnknownCheckType < Exception
    end

    # Used if one tries to register an
    # incompatible comparator
    class IncompatibleComparator < Exception
    end

    # Used if one tries to delete an
    # unexisting probe
    class CheckDoesNotExist < Exception
    end
  end
end
