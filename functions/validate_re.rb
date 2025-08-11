# frozen_string_literal: true
Puppet::Functions.create_function(:validate_re) do
  # Matches: validate_re($string, $pattern_or_patterns, Optional[$message])
  dispatch :validate do
    param 'Any', :value
    param 'Any', :patterns
    optional_param 'String', :message
  end

  def validate(value, patterns, message = nil)
    Puppet.deprecation_warning('validate_re is deprecated; prefer Pattern[...] typing or assert_type(Pattern[/re/], $x).')

    # Legacy semantics require a String as first arg
    unless value.is_a?(String)
      raise Puppet::Error, 'validate_re(): first argument must be a String'
    end

    # Accept a single String/Regexp, or an Array of them
    pats = patterns.is_a?(Array) ? patterns : [patterns]
    compiled = pats.map do |p|
      case p
      when Regexp then p
      when String then Regexp.new(p)
      else
        raise Puppet::Error, 'validate_re(): patterns must be String, Regexp, or Array thereof'
      end
    end

    ok = compiled.any? { |rx| value.match?(rx) }
    raise Puppet::Error, (message || "validate_re(): '#{value}' does not match #{compiled.map(&:inspect).join(', ')}") unless ok
    nil
  end
end
