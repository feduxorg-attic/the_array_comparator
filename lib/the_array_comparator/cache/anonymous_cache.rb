#encoding: utf-8

# the main module
module TheArrayComparator
  #caching strategies
  module Cache
    #anonymous cache
    class AnonymousCache

      # Create cache
      def initialize
        @cache = []
        @new_objects = false
      end

      # Add object to cache
      #
      # @param [Object] obj
      #   the object which should be added to the cache
      #
      # @return [Object]
      #   the object which has beed added
      def add(obj)
        @cache << obj
        @new_objects = true

        obj
      end

      # Return all stored objects
      #
      # @return [Array]
      #   the cache
      def stored_objects
        @new_objects = false
        @cache
      end

      # Clear the cache (delete all objects)
      def clear
        @cache = []
      end

      # Are there new objects
      #
      # @return [TrueClass,FalseClass]
      #   the result of the check
      def new_objects?
        @new_objects
      end

      # Delete an object from cache by number
      #
      # @return
      #   the deleted object
      def delete_object(num)
        @cache.delete_at(num)
      end

      # Request an object from cache by number
      #
      # @return
      #   the requested object
      def fetch_object(num)
        @cache[num]
      end
    end
  end
end
