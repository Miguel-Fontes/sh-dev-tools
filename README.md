# sh-dev-tools

Scripts that aim to make a developer's life easier.

## Aliases

Contains scripts with interesting aliases, making your job around the terminal simpler. Documentation about each Aliases can be found at each file.

The recommended way of using those files is to include then as a call into your favorite environment configuration file, like .bashrc or .zshcfg.

Personally, if you use Zsh, i suggest that you include the ./zsh.sh into your .zshrc. Then, you can simply add any other alias script you like and run `zshupd` to update your terminal enrionment.

``` shell
# Inside your .zshrc
./git.sh
./zsh.sh

```

## Mvn

This directory contains scripts that supports Maven operations. The scripts are documented but a overview can be found below.

### Module

This script aims to make your life creating and adding more submodules to a maven project easier. This is done by taking into account that many times we use the same archetype over and over on our projects so:

- The scripts makes it possible to configure a archetype as a environment variable for Parent and Child modules;
- Using that information, it is possible to just execute `module my-project myproject' to create a new module.
- The following environment variables must be set on your favorite environment configuration file:
  - PARENT_ARCHETYPE_ARTIFACT_ID : a default archetype used when building a parent module
  - PARENT_ARCHETYPE_GROUP_ID    : the default parent module archetype group id
  - CHILD_ARCHETYPE_ARTIFACT_ID  : the default archetype used when creating a child module
  - CHILD_ARCHETYPE_GROUP_ID     : the child module archetype group id
  - DEFAULT_GROUP_ID             : a default group id, used when no group id is defined by arguments

