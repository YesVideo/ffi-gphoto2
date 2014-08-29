require 'gphoto2'

def visit(widget, level = 0)
  indent = '  ' * level

  puts "#{indent}#{widget.name}"

  if widget.type == :window || widget.type == :section
    widget.children.each { |child| visit(child, level + 1) }
    return
  end

  indent << '  '

  puts "#{indent}type: #{widget.type}"

  puts "#{indent}value: #{widget.value}"

  case widget.type
  when :range
    range = widget.range
    step = (range.size > 1) ? range[1] - range[0] : 1.0
    puts "#{indent}options: #{range.first}..#{range.last}:step(#{step})"
  when :radio, :menu
    puts "#{indent}options: #{widget.choices.inspect}"
  end
end

camera = GPhoto2::Camera.first

begin
  visit(camera.window)
ensure
  camera.finalize
end
