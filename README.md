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

- Can not totally destroy eks cluster, pop up `Error: Unauthorized`

    ```
    module.eks.aws_iam_role_policy_attachment.workers_AmazonEC2ContainerRegistryReadOnly[0]: Destruction complete after 2s

    Error: Unauthorized
    ```

    ```
    cd terraform/eks-<worker/node>/
    terraform state rm 'module.eks.kubernetes_config_map.aws_auth[0]'
    cd ../../
    auto/destroy-eks-<worker/node>-test
    ```

- Worker groups or node groups?

    https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/faq.md#what-is-the-difference-between-node_groups-and-worker_groups

- Use the AWS CLI update-kubeconfig to update eks cluster `kubeconfig`

    ```
    aws eks --region <region-code> update-kubeconfig --name <cluster_name>
    ```

- Check aws-auth ConfigMap for RBAC access to IAM users and roles

    ```
    kubectl describe configmap -n kube-system aws-auth
    ```


- How pod get iam access to aws entity

  - Create an IAM role with a trust relationship that is scoped to your cluster's OIDC provider, the service account namespace, and (optionally) the service account name, and then attach the IAM policy that you want to associate with the service account. You can add multiple entries in the StringEquals and StringLike conditions below to use multiple service accounts or namespaces with the role.

    ```
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Federated": "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/<OIDC_PROVIDER>"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
            "StringEquals": {
            "<OIDC_PROVIDER>:sub": "system:serviceaccount:<SERVICE_ACCOUNT_NAMESPACE>:<SERVICE_ACCOUNT_NAME>"
            }
        }
        }
    ]
    }
    ```

  - Define the IAM role to associate with a service account in your cluster by adding the eks.amazonaws.com/role-arn annotation to the service account

      ```
      apiVersion: v1
      kind: ServiceAccount
      metadata:
      annotations:
          eks.amazonaws.com/role-arn: arn:aws:iam::<AWS_ACCOUNT_ID>:role/<IAM_ROLE_NAME>
      ```

  - The [Amazon EKS Pod Identity Webhook](https://github.com/aws/amazon-eks-pod-identity-webhook) on the cluster watches for pods that are associated with service accounts with this annotation and applies the following environment variables to them.

      ```
      kubectl exec -it -n <NAMESPACE> <POD_NAME> -- bash
      $ env | grep AWS
      AWS_ROLE_ARN=arn:aws:iam::<AWS_ACCOUNT_ID>:role/<IAM_ROLE_NAME>
      AWS_WEB_IDENTITY_TOKEN_FILE=/var/run/secrets/eks.amazonaws.com/serviceaccount/token
      ```

    More details: https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts-technical-overview.html

- SSH eks node via pod rather than setup a bastion

    ```
    kubectl apply -f terraform/eks-node/example/pod-assume-role.yaml
    NODE_IP=$(kubectl get nodes --selector=<node_label> -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')
    kubectl exec -it nginx-demo -- ssh -i ~/.ssh/id_rsa ec2-user@$NODE_IP
    ```
