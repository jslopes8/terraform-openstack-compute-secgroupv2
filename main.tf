/* Create by Jonatas Lopes (jslopes@uoldiveo.com) */

resource "openstack_compute_secgroup_v2" "secgroup" {

    name        = "${var.name}"
    description = "${var.description}"

    dynamic "rule" {
        for_each    = var.rule
        content {
            from_port       = lookup(rule.value, "from_port", null)
            to_port         = lookup(rule.value, "to_port", null)
            ip_protocol     = lookup(rule.value, "ip_protocol", null)
            cidr            = lookup(rule.value, "cidr", null)
            from_group_id   = lookup(rule.value, "from_grou_id", null)
            self            = lookup(rule.value, "self", null)
        }
    }
}
