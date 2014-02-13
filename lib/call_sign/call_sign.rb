module CallSign
  class CallSign

    EXTRACT_REGEX = /^(?<prefix>[BFGIKMNRW]{1}|[A-Z]{1}[0-9]{1}|[0-9][A-Z]|[A-Z]|[0-9A-Z]{3})(?<separator>[0-9]{1})(?<suffix>[0-9A-Z]{1,5})$/

    def initialize(call_sign)
      @text = call_sign
      components = CallSign.extract(call_sign)

      if components && components.is_a? Hash
        @call_sign = components[:text]
        @prefix    = components[:prefix]
        @separator = components[:separator]
        @text      = components[:text]
        @valid     = true
      else
        @call_sign = nil
        @prefix    = nil
        @separator = nil
        @suffix    = nil
        @valid     = false
      end
    end

    def valid?
      @valid
    end

    def self.extract(call_sign)
      # Check for exceptions
      # 1-letter prefix
      # 2-letter prefix
      # 3-letter prefix
      # Match regex
      match = EXTRACT_REGEX.match(call_sign)
      return if !match

      { text: match.string, prefix: match[:prefix], separator: match[:separator], suffix: match[:suffix] }
    end


    def self.parse(call_sign)
      CallSign.new(call_sign)
    end

  end
end
