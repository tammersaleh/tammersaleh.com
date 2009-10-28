class Test::Unit::TestCase
  def self.get_to_index(opts = {}, &blk)
    name = "on GET to :index"
    name += " with #{opts.inspect}" unless opts.empty?
    context name do
      setup { get :index, opts }
      merge_block(&blk)
    end
  end

  def accept(ext)
    @request.accept = Mime::EXTENSION_LOOKUP[ext.to_s]
  end
end
