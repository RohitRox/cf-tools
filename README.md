# Using this tool

```shell
  $ git clone git@github.com:RohitRox/cf-tools.git ~/.cf-tools
  $ echo '[[ -s "$HOME/.cf-tools" ]] && source "$HOME/.cf-tools/run.sh"' >> .bashrc # or .zshrc if using zsh
  $ . ~/.bashrc # . ~/.zshrc if using zsh
  $ cp ~/.cf-tools/.env.sample ~/cf-tools/.env # and modify .env accordingly
  $ cf-tools load-env
  $ cf-tools usage
  $ cf-tools # displays current config
```

# Setting cf-tools environment variables

```shell
  $ cf-tools config # show current environment settings
  $ cf-tools load-env # load env from /path/to/cf-tools/.env
  $ cf-tools setenv alpha # sets the ENV_LABEL
```

# Github token

Generate a new token with read only access to use with cf-tools.
[https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)

This token is required to access private repositories which are used as a part of the build process.

# More Information

The scaffold go service comes with dockerized granitic app with [https://github.com/cloudfactory/service-core](https://github.com/cloudfactory/service-core) baked in with corrleation id support.

In future we will be adding more default features built-in to the scaffold.
