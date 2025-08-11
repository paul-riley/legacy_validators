# frozen_string_literal: true

Puppet::Functions.create_function(:validate_absolute_path) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    raise Puppet::Error, 'validate_absolute_path(): wrong number of arguments (0; must be > 0)' if args.empty?
    msg = (args.length > 1 && args[-1].is_a?(String)) ? args.pop : nil

    t1 = Puppet::Pops::Types::TypeParser.singleton.parse('Stdlib::Absolutepath')
    ta = Puppet::Pops::Types::TypeParser.singleton.parse('Array[Stdlib::Absolutepath]')

    args.each do |arg|
      type = arg.is_a?(Array) ? ta : t1
      if msg
        call_function('assert_type', type, arg) { |_e, _a| raise Puppet::Error, msg }
      else
        call_function('assert_type', type, arg)
      end
    end
    nil
  end
end
