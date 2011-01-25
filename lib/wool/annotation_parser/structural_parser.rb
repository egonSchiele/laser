# Autogenerated from a Treetop grammar. Edits may be lost.


require 'wool/annotation_parser/useful_parsers_parser'
module Wool
  module Parsers
    module Structural
      include Treetop::Runtime

      def root
        @root ||= :structural_constraint
      end

      include GeneralPurpose

      module StructuralConstraint0
        def method_name
          elements[1]
        end

        def parenthesized_type_list
          elements[3]
        end

        def return_type
          elements[7]
        end
      end

      module StructuralConstraint1
        def type
          result = Types::StructuralType.new(
              method_name.text_value, parenthesized_type_list.all_types,
              return_type.type)
        end
      end

      module StructuralConstraint2
        def method_name
          elements[1]
        end

        def parenthesized_type_list
          elements[3]
        end

        def return_type
          elements[5]
        end
      end

      module StructuralConstraint3
        def type
          result = Types::StructuralType.new(
              method_name.text_value, parenthesized_type_list.all_types,
              return_type.type)
        end
      end

      module StructuralConstraint4
        def method_name
          elements[1]
        end

        def parenthesized_type_list
          elements[3]
        end
      end

      module StructuralConstraint5
        def type
          result = Types::StructuralType.new(
              method_name.text_value, parenthesized_type_list.all_types, [])
        end
      end

      module StructuralConstraint6
        def method_name
          elements[1]
        end

        def return_type
          elements[5]
        end
      end

      module StructuralConstraint7
        def type
          result = Types::StructuralType.new(
              method_name.text_value, [], return_type.type)
        end
      end

      module StructuralConstraint8
        def method_name
          elements[1]
        end
      end

      module StructuralConstraint9
        def type
          result = Types::StructuralType.new(method_name.text_value, [], [])
        end
      end

      def _nt_structural_constraint
        start_index = index
        if node_cache[:structural_constraint].has_key?(index)
          cached = node_cache[:structural_constraint][index]
          if cached
            cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
            @index = cached.interval.end
          end
          return cached
        end

        i0 = index
        i1, s1 = index, []
        if has_terminal?('#', false, index)
          r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('#')
          r2 = nil
        end
        s1 << r2
        if r2
          r3 = _nt_method_name
          s1 << r3
          if r3
            s4, i4 = [], index
            loop do
              r5 = _nt_space
              if r5
                s4 << r5
              else
                break
              end
            end
            r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
            s1 << r4
            if r4
              r6 = _nt_parenthesized_type_list
              s1 << r6
              if r6
                s7, i7 = [], index
                loop do
                  r8 = _nt_space
                  if r8
                    s7 << r8
                  else
                    break
                  end
                end
                r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
                s1 << r7
                if r7
                  if has_terminal?('->', false, index)
                    r9 = instantiate_node(SyntaxNode,input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure('->')
                    r9 = nil
                  end
                  s1 << r9
                  if r9
                    s10, i10 = [], index
                    loop do
                      r11 = _nt_space
                      if r11
                        s10 << r11
                      else
                        break
                      end
                    end
                    r10 = instantiate_node(SyntaxNode,input, i10...index, s10)
                    s1 << r10
                    if r10
                      r12 = _nt_type
                      s1 << r12
                    end
                  end
                end
              end
            end
          end
        end
        if s1.last
          r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
          r1.extend(StructuralConstraint0)
          r1.extend(StructuralConstraint1)
        else
          @index = i1
          r1 = nil
        end
        if r1
          r0 = r1
        else
          i13, s13 = index, []
          if has_terminal?('#', false, index)
            r14 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('#')
            r14 = nil
          end
          s13 << r14
          if r14
            r15 = _nt_method_name
            s13 << r15
            if r15
              s16, i16 = [], index
              loop do
                r17 = _nt_space
                if r17
                  s16 << r17
                else
                  break
                end
              end
              r16 = instantiate_node(SyntaxNode,input, i16...index, s16)
              s13 << r16
              if r16
                r18 = _nt_parenthesized_type_list
                s13 << r18
                if r18
                  s19, i19 = [], index
                  loop do
                    r20 = _nt_space
                    if r20
                      s19 << r20
                    else
                      break
                    end
                  end
                  r19 = instantiate_node(SyntaxNode,input, i19...index, s19)
                  s13 << r19
                  if r19
                    r21 = _nt_type
                    s13 << r21
                  end
                end
              end
            end
          end
          if s13.last
            r13 = instantiate_node(SyntaxNode,input, i13...index, s13)
            r13.extend(StructuralConstraint2)
            r13.extend(StructuralConstraint3)
          else
            @index = i13
            r13 = nil
          end
          if r13
            r0 = r13
          else
            i22, s22 = index, []
            if has_terminal?('#', false, index)
              r23 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure('#')
              r23 = nil
            end
            s22 << r23
            if r23
              r24 = _nt_method_name
              s22 << r24
              if r24
                s25, i25 = [], index
                loop do
                  r26 = _nt_space
                  if r26
                    s25 << r26
                  else
                    break
                  end
                end
                r25 = instantiate_node(SyntaxNode,input, i25...index, s25)
                s22 << r25
                if r25
                  r27 = _nt_parenthesized_type_list
                  s22 << r27
                end
              end
            end
            if s22.last
              r22 = instantiate_node(SyntaxNode,input, i22...index, s22)
              r22.extend(StructuralConstraint4)
              r22.extend(StructuralConstraint5)
            else
              @index = i22
              r22 = nil
            end
            if r22
              r0 = r22
            else
              i28, s28 = index, []
              if has_terminal?('#', false, index)
                r29 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('#')
                r29 = nil
              end
              s28 << r29
              if r29
                r30 = _nt_method_name
                s28 << r30
                if r30
                  s31, i31 = [], index
                  loop do
                    r32 = _nt_space
                    if r32
                      s31 << r32
                    else
                      break
                    end
                  end
                  r31 = instantiate_node(SyntaxNode,input, i31...index, s31)
                  s28 << r31
                  if r31
                    if has_terminal?('->', false, index)
                      r33 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure('->')
                      r33 = nil
                    end
                    s28 << r33
                    if r33
                      s34, i34 = [], index
                      loop do
                        r35 = _nt_space
                        if r35
                          s34 << r35
                        else
                          break
                        end
                      end
                      r34 = instantiate_node(SyntaxNode,input, i34...index, s34)
                      s28 << r34
                      if r34
                        r36 = _nt_type
                        s28 << r36
                      end
                    end
                  end
                end
              end
              if s28.last
                r28 = instantiate_node(SyntaxNode,input, i28...index, s28)
                r28.extend(StructuralConstraint6)
                r28.extend(StructuralConstraint7)
              else
                @index = i28
                r28 = nil
              end
              if r28
                r0 = r28
              else
                i37, s37 = index, []
                if has_terminal?('#', false, index)
                  r38 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure('#')
                  r38 = nil
                end
                s37 << r38
                if r38
                  r39 = _nt_method_name
                  s37 << r39
                end
                if s37.last
                  r37 = instantiate_node(SyntaxNode,input, i37...index, s37)
                  r37.extend(StructuralConstraint8)
                  r37.extend(StructuralConstraint9)
                else
                  @index = i37
                  r37 = nil
                end
                if r37
                  r0 = r37
                else
                  @index = i0
                  r0 = nil
                end
              end
            end
          end
        end

        node_cache[:structural_constraint][start_index] = r0

        r0
      end

    end

    class StructuralParser < Treetop::Runtime::CompiledParser
      include Structural
    end

  end
end