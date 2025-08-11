# frozen_string_literal: true

Puppet::Functions.create_function(:is_array) do
  # @summary
  #   Returns true if the given value is an Array, false otherwise.
  #
  # @example Using is_array
  #   is_array([])            # => true
  #   is_array(['a', 'b'])    # => true
  #   is_array('not array')   # => false
  #
  # @param value The value to check.
  #
  # @return [Boolean] true if value is an Array, false otherwise.
  dispatch :is_array do
    param 'Any', :value
  end

  def is_array(value)
    value.is_a?(Array)
  end
end
