module CallSign
  class ITUPrefix

    def initialize(prefix='')
      @prefix = nil
      determine_prefix(prefix)
    end
    
    def determine_prefix(prefix)
    end

    def parse(prefix)
      self.new(prefix)
    end

  end
end
