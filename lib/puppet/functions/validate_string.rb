# frozen_string_literal: true

Puppet::Functions.create_function(:validate_string) do
  dispatch :validate do
    repeated_param 'Any', :args
  end

  def validate(*args)
    raise Puppet::Error, 'validate_string(): wrong number of arguments (0; must be > 0)' if args.empty?

    # Optional trailing custom message (kept for legacy compatibility)
    msg = (args.length > 1 && args[-1].is_a?(String)) ? args.pop : nil

    t1 = Puppet::Pops::Types::TypeParser.singleton.parse('String')
    ta = Puppet::Pops::Types::TypeParser.singleton.parse('Array[String]')

    args.each do |arg|
      type = arg.is_a?(Array) ? ta : t1
      if msg
        call_function('assert_type', type, arg) do |_expected, _actual|
          # Raise with the legacy custom message
          raise Puppet::Error, msg
        end
      else
        call_function('assert_type', type, arg)
      end
    end
    nil
  end
end
