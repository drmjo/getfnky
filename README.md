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

i.e.
to create the lambda deployment bucket
```
make create-lambda-bucket
```
