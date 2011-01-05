module Wool
  module SexpAnalysis
    # This class represents a GenericBinding in Ruby. It may have a known protocol (type),
    # class, value (if constant!), and a variety of other details.
    class GenericBinding
      include Comparable
      attr_accessor :name
      attr_reader :value

      def initialize(name, value)
        @name = name
        @value = :uninitialized
        bind!(value)
      end
      
      def bind!(value)
        if respond_to?(:validate_value)
          validate_value(value)
        end
        @value = value
      end
      
      def <=>(other)
        self.name <=> other.name
      end
      
      def scope
        value.scope
      end
      
      def protocol
        value.protocol
      end
      
      def class_used
        value.klass
      end
      
      def inspect
        "#<GenericBinding: #{name}>"
      end
    end
    
    # Constants have slightly different properties in their bindings: They shouldn't
    # be rebound. However.... Ruby allows it. It prints a warning when the rebinding
    # happens, but we should be able to detect this statically. Oh, and they can't be
    # bound inside a method. That too is easily detected statically.
    class ConstantBinding < GenericBinding
      # Require an additional force parameter to rebind a Constant. That way, the user
      # can configure whether rebinding counts as a warning or an error.
      def bind!(val, force=false)
        if @value != :uninitialized && !force
          raise TypeError.new('Cannot rebind a constant binding without const_set')
        end
        super(val)
      end
    end
  end
end