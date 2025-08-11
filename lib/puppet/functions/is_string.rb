# frozen_string_literal: true

Puppet::Functions.create_function(:is_string) do
  # @summary
  #   Returns true if the given value is a String, false otherwise.
  #
  # @example Using is_string
  #   is_string('hello')     # => true
  #   is_string(['a', 'b'])  # => false
  #   is_string(123)         # => false
  #
  # @param value The value to check.
  #
  # @return [Boolean] true if value is a String, false otherwise.
  dispatch :is_string do
    param 'Any', :value
  end

  def is_string(value)
    value.is_a?(String)
  end
end
