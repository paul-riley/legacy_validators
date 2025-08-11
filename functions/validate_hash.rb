# frozen_string_literal: true
Puppet::Functions.create_function(:validate_hash) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    Puppet.deprecation_warning('validate_hash is deprecated; use Hash typing or assert_type(Hash, $x).')
    raise Puppet::Error, 'validate_hash(): wrong number of arguments (0; must be > 0)' if args.empty?

    msg = args.length > 1 && args[-1].is_a?(String) ? args.pop : nil
    t = Puppet::Pops::Types::TypeParser.singleton.parse('Hash')

    args.each do |arg|
      msg ? call_function('assert_type', t, arg, msg) : call_function('assert_type', t, arg)
    end
    nil
  end
end
