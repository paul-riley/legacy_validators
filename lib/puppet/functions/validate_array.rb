# frozen_string_literal: true

Puppet::Functions.create_function(:validate_array) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    Puppet.deprecation_warning('validate_array is deprecated; use Array typing or assert_type(Array, $x).')
    raise Puppet::Error, 'validate_array(): wrong number of arguments (0; must be > 0)' if args.empty?

    msg = (args.length > 1 && args[-1].is_a?(String)) ? args.pop : nil
    t = Puppet::Pops::Types::TypeParser.singleton.parse('Array')

    args.each do |arg|
      msg ? call_function('assert_type', t, arg, msg) : call_function('assert_type', t, arg)
    end
    nil
  end
end
