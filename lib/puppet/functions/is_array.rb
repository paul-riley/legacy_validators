# frozen_string_literal: true

Puppet::Functions.create_function(:is_array) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    raise Puppet::Error, 'validate_array(): wrong number of arguments (0; must be > 0)' if args.empty?

    msg = nil
    if args.length > 1 && args[-1].is_a?(String)
      msg = args.pop
    end

    t = Puppet::Pops::Types::TypeParser.singleton.parse('Array')

    args.each do |arg|
      if msg
        call_function('assert_type', t, arg) { |_expected, _actual| raise Puppet::Error, msg }
      else
        call_function('assert_type', t, arg)
      end
    end
    nil
  end
end
