region = "ap-southeast-1"
instance_type = "t3.medium"

map_roles = [
    {
      rolearn  = "arn:aws:iam::494526681395:role/toc-admin"
      username = "toc-admin"
      groups   = ["system:masters"]
    },
]
