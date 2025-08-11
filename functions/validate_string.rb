# frozen_string_literal: true
Puppet::Functions.create_function(:validate_string) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    Puppet.deprecation_warning('validate_string is deprecated; use String typing or assert_type(String, $x).')
    raise Puppet::Error, 'validate_string(): wrong number of arguments (0; must be > 0)' if args.empty?

    # Optional trailing custom message (legacy pattern)
    msg = args.length > 1 && args[-1].is_a?(String) ? args.pop : nil

    t1 = Puppet::Pops::Types::TypeParser.singleton.parse('String')
    ta = Puppet::Pops::Types::TypeParser.singleton.parse('Array[String]')

    args.each do |arg|
      type = arg.is_a?(Array) ? ta : t1
      msg ? call_function('assert_type', type, arg, msg) : call_function('assert_type', type, arg)
    end
    nil
  end
end
