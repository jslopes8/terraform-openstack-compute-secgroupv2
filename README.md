# Terraform module to Openstack (Neutron v10)
Manages a V2 security group resource within OpenStack.

O codigo irá prover os seguintes recursos no Openstack.
* [Compute Security Group](https://www.terraform.io/docs/providers/openstack/r/compute_secgroup_v2.html)



## The `rule` block supports:

`from_port`       - (Required) An integer representing the lower bound of the port range to open. Changing this creates a new security group rule.

`to_port`         - (Required) An integer representing the upper bound of the port range to open. Changing this creates a new security group rule.

`ip_protocol`     - (Required) The protocol type that will be allowed. Changing this creates a new security group rule.

`cidr`            - (Optional) Required if `from_group_id` or self is empty. The IP range that will be the source of network traffic to the security group. Use 0.0.0.0/0 to allow all IP addresses. Changing this creates a new security group rule. Cannot be combined with from_group_id or self.

`from_group_id`   - (Optional) Required if cidr or self is empty. The ID of a group from which to forward traffic to the parent group. Changing this creates a new security group rule. Cannot be combined with cidr or self.

`self`            - (Optional) Required if cidr and from_group_id is empty. If true, the security group itself will be added as a source to this ingress rule. Cannot be combined with cidr or from_group_id.



## Usage
Example create Security Group for VM Instance

```hcl
module "create_securityGroup" {
    source  = "./modules/networking/security_group/"

    name        = "Security Group allow port 22
    description = "Allow SSH Remote Security Group"
    rule    = [
        {
            from_port   = "22"
            to_port     = "22"
            ip_protocol = "tcp"
            cidr        = "0.0.0.0/0"
        }
    ]
}


```

Example to ICMP
```hcl
module "create_securityGroup" {
    source  = "./modules/computer/"

...
    rule    = [
        {
            from_port   = "-1"
            to_port     = "-1"
            ip_protocol = "icmp"
            self        = "true"
        }
    ]


}
```


Example to multiple firewall rules
```hcl
module "create_vm" {
    source  = "./modules/computer/"

...

    rule    = [
        {
            from_port   = "22"
            to_port     = "22"
            ip_protocol = "tcp"
            cidr        = "0.0.0.0/0"
        },
        {
            from_port   = "80"
            to_port     = "80"
            ip_protocol = "tcp"
            cidr        = "0.0.0.0/0"
        },
        {
            ip_protocol     = "tcp"
            from_port       = "443"
            to_port         = "443"
            from_group_id   = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        }
    ]
...

}
```

## Variable Outputs

| Name | Description |
| ---- | ----------- |
| sg_name | Return with name of the resource create |
| sg_id | Return with Id of the resource create |