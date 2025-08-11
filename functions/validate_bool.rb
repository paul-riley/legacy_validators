# frozen_string_literal: true
Puppet::Functions.create_function(:validate_bool) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    Puppet.deprecation_warning('validate_bool is deprecated; use Boolean typing or assert_type(Boolean, $x).')
    raise Puppet::Error, 'validate_bool(): wrong number of arguments (0; must be > 0)' if args.empty?

    msg = args.length > 1 && args[-1].is_a?(String) ? args.pop : nil
    t1 = Puppet::Pops::Types::TypeParser.singleton.parse('Boolean')
    ta = Puppet::Pops::Types::TypeParser.singleton.parse('Array[Boolean]')

    args.each do |arg|
      type = arg.is_a?(Array) ? ta : t1
      msg ? call_function('assert_type', type, arg, msg) : call_function('assert_type', type, arg)
    end
    nil
  end
end
