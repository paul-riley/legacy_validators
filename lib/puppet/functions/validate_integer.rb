# frozen_string_literal: true

Puppet::Functions.create_function(:validate_integer) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    Puppet.deprecation_warning('validate_integer is deprecated; use Integer typing or assert_type(Integer, $x).')
    raise Puppet::Error, 'validate_integer(): wrong number of arguments (0; must be > 0)' if args.empty?

    msg = (args.length > 1 && args[-1].is_a?(String)) ? args.pop : nil
    t1 = Puppet::Pops::Types::TypeParser.singleton.parse('Integer')
    ta = Puppet::Pops::Types::TypeParser.singleton.parse('Array[Integer]')

    args.each do |arg|
      type = arg.is_a?(Array) ? ta : t1
      msg ? call_function('assert_type', type, arg, msg) : call_function('assert_type', type, arg)
    end
    nil
  end
end
