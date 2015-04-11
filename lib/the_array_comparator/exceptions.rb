# the main module
module TheArrayComparator
  # exceptions which are going to be raised under
  # certain conditions
  module Exceptions
    # Used if one tries to add an unknown
    # check type
    class UnknownCheckType < Exception
    end
    #
    # Used if one tries to add an unknown
    # caching strategy
    class UnknownCachingStrategy < Exception
    end

    # Used if one tries to register an
    # incompatible comparator
    class IncompatibleComparator < Exception
    end
    #
    # Used if one tries to register an
    # incompatible caching strategy
    class IncompatibleCachingStrategy < Exception
    end

    # Used if one tries to delete an
    # unexisting probe
    class CheckDoesNotExist < Exception
    end

    # Used if one tries to use an unexisting
    # cache
    class CacheDoesNotExist < Exception
    end

    # Used if one forgot to implement that
    # method
    class MustHaveMethodNotImplemented < Exception
    end

    # Used if one use the library the wrong way
    class WrongUsageOfLibrary < Exception
    end

    # Use if one tries to register an internal
    # keyword
    class UsedInternalKeyword < Exception
    end
  end
end
