require_relative 'spec_helper'

describe ControlFlow::UnusedVariables do
  it 'should find a simple unused variable' do
    g = cfg_method <<-EOF
def foo(x)
y = gets() * 2
z = y
c = z * z
end
EOF
    g.should have_error(Laser::UnusedVariableWarning).on_line(4).with_message(/\b c \b/x)
  end

  it 'should find a more complex unused variable showing off ssa' do
    cfg <<-EOF
class Unused1
  def foo(x)
    z = gets * 10
    if z.size > 50
      y = z  # this y is used as return value
    else
      y = z * 2
      puts y
    end
  end
end
Unused1.new.foo(gets)
EOF
    method = ClassRegistry['Unused1'].instance_method(:foo)
    g = method.proc.ast_node
    g.should have_error(Laser::UnusedVariableWarning).on_line(5).with_message(/\b y \b/x)
  end
  
  it 'should see when a variable is assigned and used to compute only unused vars' do
    cfg <<-EOF
class Unused2
  def foo(x)
    z = gets * 10
    d = z * 2
    a = d
    puts z
    nil
  end
end
Unused2.new.foo(gets)
EOF
    method = ClassRegistry['Unused2'].instance_method(:foo)
    g = method.proc.ast_node
    g.should have_error(Laser::UnusedVariableWarning).on_line(4).with_message(/\b d \b/x)
    g.should have_error(Laser::UnusedVariableWarning).on_line(5).with_message(/\b a \b/x)
    g.should_not have_error(Laser::UnusedVariableWarning).with_message(/\b z \b/x)
  end

  it 'should ignore SSA variables assigned and used to compute only unused vars' do
    g = cfg_method <<-EOF
def foo(x)
z = gets * 10
if z.size > 3
  d = z * 2
  c = z
else
  d = z * 10
  c = 30
end
j = d
c
end
EOF

    g.should have_error(Laser::UnusedVariableWarning).on_line(4).with_message(/\b d \b/x)
    g.should have_error(Laser::UnusedVariableWarning).on_line(7).with_message(/\b d \b/x)
    g.should have_error(Laser::UnusedVariableWarning).on_line(10).with_message(/\b j \b/x)
  end
  
  it 'is improved by constant propagation' do
    g = cfg_method <<-EOF
def foo(x)
z = (10 ** 5).to_s(5)
if z == "11200000"
  d = z * 2
  c = z
else
  d = z * 10
  c = 30
end
j = d
c
end
EOF

    g.should have_error(Laser::UnusedVariableWarning).on_line(4).with_message(/\b d \b/x)
    g.should have_error(Laser::UnusedVariableWarning).on_line(7).with_message(/\b d \b/x)
    g.should have_error(Laser::UnusedVariableWarning).on_line(8).with_message(/\b c \b/x)
    g.should have_error(Laser::UnusedVariableWarning).on_line(10).with_message(/\b j \b/x)
  end
  
  it 'recognizes unused variables introduced through multiple assignment' do
    g = cfg_method <<-EOF
def foo(x)
y = gets() * 2
z, i = y, 3
c = z * z
end
EOF
    g.should have_error(Laser::UnusedVariableWarning).on_line(3).with_message(/\b i \b/x)
    g.should have_error(Laser::UnusedVariableWarning).on_line(4).with_message(/\b c \b/x)
  end
end
