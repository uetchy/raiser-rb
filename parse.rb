require 'parser/ruby26'
require 'unparser'

source_string = File.open('./Gemfile').read()
node = Parser::Ruby26.parse(source_string)
node.children.each do |child_node|
  # p child_node.loc.expression.source
  selector = child_node.loc.selector.source
  case selector
  when 'source' then
    source_url = child_node.children[2].children[0]
    puts "sourcing from '#{source_url}'"
  when 'gem' then
    gem_name = child_node.children[2].children[0]
    gem_version = child_node.children[3].children[0]
    puts "#{gem_name} (#{gem_version})"
  end
end

puts Unparser.unparse(node)