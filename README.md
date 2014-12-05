opsworks-bashrc cookbook
===========================

This cookbook setups a custom bashrc file for easy additions of ENV variables,
aliases, scripts, and even external files to be sourced into bash, specifically
for servers booted up through Amazon's opsworks platform.


Requirements
------------

* Chef 10+


Attributes
----------

* `node['opsworks_bashrc']['custom_env_variables']` - Extra environment
  variables to add to each session (key is the variable name, and the value is
  the value).  

  Defaults to: `{}`  
  Example:
  
  ```
  node['opsworks_bashrc']['custom_env_variables']['RAILS_ENV'] = 'production'
  ```
* `node['opsworks_bashrc']['custom_bash_aliases']` - Extra aliases to add to
  each session (key is the alias name, and the value is the command).

  Defaults to: `{}`  
  Example:
  
  ```
  node['opsworks_bashrc']['custom_bash_aliases']['console'] = 'cdc; sudo bundle exec rails console $RAILS_ENV'
  ```
* `node['opsworks_bashrc']['custom_bash_scripts']` - An array of strings that
  evaulates to valid bash code.  
  
  Defaults to: `[]`   
  Example:
  
  ```
  node['opsworks_bashrc']['custom_bash_scripts'] << 'export PATH=$PATH:/super/cool/bin/location'
  ```
* `node['opsworks_bashrc']['custom_source_files']` - External files located in
  other cookbook (the key is the cookbook, and the value is the file).  
  
  Defaults to: `{}`  
  Example:
  
  ```
  node['opsworks_bashrc']['custom_bash_aliases']['foobar'] = 'foo.sh'
  ```

Recipes
-------

* `default` - Adds the custom bashrc file and adds any additions defined in the
  attribues.


Author
------

Sport Ngin

