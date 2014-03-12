module Future
  extend ActiveSupport::Concern
  class FutureProxy < BasicObject
    def initialize(target)
      @target = target
    end

    def method_missing(method,*args,&block)
      ::Celluloid::Future.new {
        @target.send(method,*args,&block)
      }
    end
  end

  def future(&block)
    if block
      ::Celluloid::Future.new {
        block.call(self)
      }
    else
      FutureProxy.new(self)
    end
  end
end