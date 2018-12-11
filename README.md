# Using this tool

```shell
  $ git clone git@github.com:RohitRox/cf-tools.git ~/cf-tools
  $ cp ~/cf-tools/.env.sample ~/cf-tools/.env # and modify .env accordingly
  $ source ~/cf-tools/run.sh
  $  cf-tools load-env
  $ cf-tools usage
```

# Setting cf-tools environment variables

```shell
  $ cf-tools config # show current environment settings
  $ cf-tools load-env # load env from /path/to/cf-tools/.env
  $ export AWS_PROFILE=swm # just set the environment directly
```
