# legacy_validators

Welcome to your new module. A short overview of the generated parts can be found
in the [PDK documentation][1].

The README template below provides a starting point with details about what
information to include in your README.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with legacy_validators](#setup)
    * [What legacy_validators affects](#what-legacy_validators-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with legacy_validators](#beginning-with-legacy_validators)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This is a module that reproduces the validate_<thing> functionality for Ruby 3.2, to work with Puppet 8 and newer.

### Beginning with legacy_validators

Add this module to your Puppetfile

## Usage

`validate_bool($_boolean)`
`validate_absolute_path($_path)`
`validate_array($_array)`
`validate_bool($_bool)`
`validate_cmd($_cmd)`
`validate_hash($_hash)`
`validate_integer($_integer)`
`validate_re($_regex)`
`validate_string($_string)`

Returns a True or False based on the status of the variable.


## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel are
necessary or important to include here. Please use the `##` header.

[1]: https://puppet.com/docs/pdk/latest/pdk_generating_modules.html
[2]: https://puppet.com/docs/puppet/latest/puppet_strings.html
[3]: https://puppet.com/docs/puppet/latest/puppet_strings_style.html
# legacy_validators
