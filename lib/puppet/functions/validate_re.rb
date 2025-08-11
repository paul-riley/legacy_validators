# frozen_string_literal: true

Puppet::Functions.create_function(:validate_re) do
  # validate_re($value, $pattern_or_patterns, Optional[$message])
  dispatch :validate do
    param 'Any', :value
    param 'Any', :patterns
    optional_param 'String', :message
  end

  def validate(value, patterns, message = nil)
    unless value.is_a?(String)
      raise Puppet::Error, 'validate_re(): first argument must be a String'
    end

    pats = patterns.is_a?(Array) ? patterns : [patterns]
    compiled = pats.map do |p|
      case p
      when Regexp then p
      when String then Regexp.new(p)
      else
        raise Puppet::Error, 'validate_re(): patterns must be String, Regexp, or Array of those'
      end
    end

    matched = compiled.any? { |rx| value.match?(rx) }
    unless matched
      raise Puppet::Error, (message || "validate_re(): '#{value}' does not match #{compiled.map(&:inspect).join(', ')}")
    end
    nil
  end
end
