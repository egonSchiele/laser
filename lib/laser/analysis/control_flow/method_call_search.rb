module Laser
  module SexpAnalysis
    module ControlFlow
      # Finds the properties of how the code yields to a block argument.
      # Should not be used on top-level code, naturally.
      module MethodCallSearch
        def find_method_calls(method_to_find)
          name_to_find = method_to_find.name.to_sym
          possible_calls = []
          vertices.each do |block|
            block.instructions.each do |insn|
              if (insn.type == :call || insn.type == :call_vararg) && insn[3] == name_to_find
                # check if method could be from insn receiver
                if insn[2].expr_type.matching_methods(name_to_find).include?(method_to_find)
                  possible_calls << insn
                end
              end
            end
          end
          possible_calls
        end
      end
    end  # ControlFlow
  end  # SexpAnalysis
end  #
