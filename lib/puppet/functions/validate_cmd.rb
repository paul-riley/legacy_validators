# frozen_string_literal: true

require 'puppet/util/execution'
require 'tempfile'

Puppet::Functions.create_function(:validate_cmd) do
  # validate_cmd($value, $command_with_percent_placeholder, Optional[$message])
  # Example: validate_cmd($content, '/usr/sbin/visudo -c -f %')
  dispatch :validate do
    param 'String', :value
    param 'String', :command
    optional_param 'String', :message
  end

  def validate(value, command, message = nil)
    tf = Tempfile.new('puppet-validate-cmd')
    begin
      tf.write(value)
      tf.flush

      cmdline = if command.include?('%')
                  command.gsub('%', tf.path)
                else
                  "#{command} #{tf.path}"
                end

      result = Puppet::Util::Execution.execute(
        cmdline,
        failonfail: false,
        combine: true,
      )

      unless result.exitstatus == 0
        raise Puppet::Error, (message || "validate_cmd(): '#{cmdline}' returned exit code #{result.exitstatus}: #{result}")
      end
    ensure
      tf.close!
    end
    nil
  end
end
