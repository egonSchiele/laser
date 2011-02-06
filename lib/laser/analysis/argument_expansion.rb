module Laser
  module SexpAnalysis
    # This class handles the interpretation and expansion of arguments being
    # passed to a method call.
    class ArgumentExpansion
      attr_reader :node
      # @node can end up either being nil, for no args at all, or an
      # args_add_block node.
      def initialize(node)
        node = node[1] if node.type == :arg_paren
        @node = node
      end
      
      # Returns whether the node has a block argument. If it does, it
      # returns the block argument's node.
      def has_block?
        if node.nil?
          false
        elsif node.type == :args_add_block
          node[2]
        end
      end
      
      # Returns the arity of the argument block being passed, as a range of
      # possible values.
      def arity
        return (0..0) if node.nil?
        arity_for_node(node)
      end
      
      private
      
      # Finds the arity of a given argument node.
      def arity_for_node(node)
        case node[0]
        when Array
          node.inject(0..0) { |acc, cur| range_add(acc, arity_for_node(cur)) }
        when :args_add_block
          arity_for_node(node[1])
        when :args_add_star
          initial = arity_for_node(node[1])
          star_arity = arity_for_star(node[2])
          extra = node.size > 3 ? arity_for_node(node[3..-1]) : (0..0)
          range_add(range_add(initial, star_arity), extra)
        else
          1..1
        end
      end
      
      # Adds two ranges together.
      def range_add(r1, r2)
        (r1.begin + r2.begin)..(r1.end + r2.end)
      end
      
      # Finds the arity for a splatted argument. If it's a constant value, we can
      # compute its value 
      def arity_for_star(node)
        if node.is_constant
          ary = node.constant_value.to_a rescue [node.constant_value]
          size = ary.size
          size..size
        else
          0..Float::INFINITY
        end
      end
    end
  end
end