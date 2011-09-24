require 'tuft/node'

module Tuft
  class NodeController    
    attr_reader :nodes
    
    def initialize
      @nodes = {}
    end
    
    def create_node(hostname, ip)
      node = Node.new(hostname, ip)
      node.add_observer self
      @nodes[hostname] = node
    end
    
    def update(hostname)
      @nodes.delete hostname
    end
    
    def destroy_node(hostname)
      @nodes[hostname].destroy
    end
    
    @@instance = NodeController.new
    class << self
      def instance
        @@instance
      end
    end
  end
end