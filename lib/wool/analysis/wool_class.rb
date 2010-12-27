module Wool
  module SexpAnalysis
    class WoolObject
      extend ModuleExtensions
      attr_reader :protocol, :scope, :klass, :name
      
      def initialize(klass = ClassRegistry['Object'], scope = Scope::GlobalScope,
                     name = "#<#{klass.path}:#{object_id.to_s(16)}>")
        @klass = klass
        @protocol = klass.protocol
        @scope = scope
        @name = name
      end
      
      def singleton_class
        return @singleton_class if @singleton_class
        @singleton_class = WoolClass.new("#<Class:#{name}>") do |new_singleton_class|
          new_singleton_class.superclass = self.klass
        end
        @singleton_class
      end
      
      def signatures
        @methods.values.map(&:signatures).flatten
      end
    end
    
    # Wool representation of a module. Named WoolModule to avoid naming
    # conflicts. It has lists of methods, instance variables, and so on.
    class WoolModule < WoolObject
      attr_reader :path, :instance_methods, :object
      
      def initialize(full_path, scope = Scope::GlobalScope)
        super(self, scope)
        
        @path = full_path
        @instance_methods = {}
        @scope = scope
        @methods = {}
        initialize_protocol
        @object = Symbol.new(:protocol => @protocol, :class_used => klass, :scope => scope,
                             :name => name, :value => self)
        initialize_scope
        yield self if block_given?
      end

      def klass
        ClassRegistry[class_name]
      end
      
      def class_name
        'Module'
      end

      # If this is a new, custom module, we can update the constant
      # table and perform module initialization.
      def initialize_scope
        if @scope && @scope != Scope::GlobalScope
          @scope.self_ptr = self.object.value
          @scope.parent.constants[name] = self.object if @scope.parent
        end
        @scope.locals['self'] = self.object if @scope
      end
      
      def initialize_protocol
        if ProtocolRegistry[class_name].empty?
          @protocol = Protocols::InstanceProtocol.new(class_name)
          ProtocolRegistry.add_class_protocol(@protocol)
        else
          @protocol = ProtocolRegistry[class_name].first
        end
        # for instances of me
        ProtocolRegistry.add_class_protocol(Protocols::InstanceProtocol.new(self))
      end
      
      def name
        self.path.split('::').last
      end
      
      def add_instance_method(method)
        @instance_methods[method.name] = method
      end
      
      def instance_signatures
        instance_methods.values.map(&:signatures).flatten
      end
      
      def add_signature(signature)
        @instance_methods[signature.name].add_signature(signature)
      end
      
      def inspect
        "#<WoolModule: #{path}>"
      end
    end

    # Wool representation of a class. I named it WoolClass so it wouldn't
    # clash with regular Class. This links the class to its protocol.
    # It inherits from WoolModule to pull in everything but superclasses.
    class WoolClass < WoolModule
      attr_reader :superclass, :subclasses
      
      def initialize(*args)
        @subclasses ||= []
        super # can yield, so must come last
      end
      
      # Adds a subclass.
      def add_subclass!(other)
        subclasses << other
      end
      
      # Removes a subclass.
      def remove_subclass!(other)
        subclasses -= [other]
      end
      
      # Sets the superclass, which handles registering/unregistering subclass
      # ownership elsewhere in the inheritance tree
      def superclass=(other)
        superclass.remove_subclass! self if superclass
        @superclass = other
        superclass.add_subclass! self
      end
      
      # The set of all superclasses (including the class itself)
      def superset
        if superclass.nil?
        then [self]
        else [self] + superclass.superset
        end
      end
      
      # The set of all superclasses (excluding the class itself)
      def proper_superset
        superset - [self]
      end
      
      # The set of all subclasses (including the class itself)
      def subset
        [self] + subclasses.map(&:subset).flatten
      end
      
      # The set of all subclasses (excluding the class itself)
      def proper_subset
        subset - [self]
      end
      
      def instance_methods
        if superclass
        then superclass.instance_methods.merge(@instance_methods)
        else @instance_methods
        end
      end
      
      def class_name
        'Class'
      end
      
      def inspect
        "#<WoolClass: #{path} superclass=#{superclass.inspect}>"
      end
    end

    # Wool representation of a method. This name is tweaked so it doesn't
    # collide with ::Method.
    class WoolMethod
      extend ModuleExtensions
      attr_reader :name, :signatures
      attr_accessor_with_default :pure, false

      def initialize(name)
        @name = name
        @signatures = []
        yield self if block_given?
      end

      def add_signature(signature)
        @signatures << signature
      end
    end
  end
end