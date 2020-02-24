# security group

resource "aws_security_group" "this" {
    name        = "${var.sg_name}.${local.lower_name}"
    description = "${var.sg_desc}"

    vpc_id = "${var.vpc_id}"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    dynamic "ingress" {
        for_each = var.source_sg_cidrs
        content {
            description     = ingress.value["desc"]
            from_port       = ingress.value["from"]
            to_port         = ingress.value["to"]
            protocol        = ingress.value["protocol"]
            cidr_blocks     = ingress.value["cidrs"]
        }
    }

    dynamic "ingress" {
        for_each = var.source_sg_ids
        content {
            description     = ingress.value["desc"]
            from_port       = ingress.value["from"]
            to_port         = ingress.value["to"]
            protocol        = ingress.value["protocol"]
            security_groups = ingress.value["security_groups"]
        }
    }

    tags = {
        Name = "${var.sg_name}.${local.lower_name}"
        SG_Groups = "${local.lower_name}"

    }

}

resource "aws_security_group_rule" "sg_ids" {
    count = length(var.source_sg_ids)

    description              = "${var.source_sg_ids[count.index].desc}"
    security_group_id        = "${aws_security_group.this.id}"
    source_security_group_id = "${var.source_sg_ids[count.index].security_groups}"
    from_port                = "${var.source_sg_ids[count.index].from}"
    to_port                  = "${var.source_sg_ids[count.index].to}"
    protocol                 = "${var.source_sg_ids[count.index].protocol}"
    type                     = "${var.source_sg_ids[count.index].type}"
}

resource "aws_security_group_rule" "sg_cidrs" {
    count = length(var.source_sg_cidrs)

    description       = "${var.source_sg_cidrs[count.index].desc}"
    security_group_id = "${aws_security_group.this.id}"
    cidr_blocks       = "${var.source_sg_cidrs[count.index].cidrs}"
    from_port         = "${var.source_sg_cidrs[count.index].from}"
    to_port           = "${var.source_sg_cidrs[count.index].to}"
    protocol          = "${var.source_sg_cidrs[count.index].protocol}"
    type              = "${var.source_sg_cidrs[count.index].type}"
}