# Terraform demo

This repo is intent to give us a better understanding regarding how to structure terraform framework for aws resources.

## Deployment

- Optimize terraform format
```
./auto/terraform fmt
```

- Provision EC2 in test/prod env
```
./auto/provision-ec2-<test/prod>
```

- Terminate EC2 in test/prod env
```
./auto/destroy-ec2-<test/prod>
```

## Notice

- Uncomment the following in [auto/terraform-action](auto/terraform-action) and `cp -rf provider.tf.bak provider.tf` if you are using IAM user credentials in `~/.aws/credentials` to authenticate your AWS account.

```bash
# auto/terraform-action
if auto/terraform -chdir=${CONF_DIR} workspace new ${ENV}; then
    display_status "Workspace '${ENV}' created!"
fi

auto/terraform -chdir=${CONF_DIR} workspace select ${ENV}
```

```bash
#  ~/.aws/credentials
[test]
aws_access_key_id=XXXXXXXXXXXXXXXXXXXXXXXXXX
aws_secret_access_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
cli_pager=
```

Otherwise, continue the current setting which applied SSO authentication.
