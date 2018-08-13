# getfnky
WIP

# Cli tools
create a `aws.env` file in the root of the project with valid aws creds
refer to `aws.env.example`
```
make aws
```
to get an aws shell

```
make terraform
```

will grant you a shell with terraform `0.11.7`

refer to the `Makefile` for all other helpers

# Deployment

build lambda
```
cd lambda/status
make
```

from the root of the repo deploy
```
make apply
```
