require 'tsort'

#
# A class that mixes the Tsort module into Hash class
#
# @author [anirudh]
#
class Hashy < Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end
