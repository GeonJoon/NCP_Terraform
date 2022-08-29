resource "ncloud_lb_target_group" "target" {
    vpc_no      = ncloud_vpc.vpc.id
    name        = var.name
    protocol    = "HTTP"
    target_type = "VSVR"
    port        = 80
    description = "for test"
    health_check {
        protocol       = "HTTP"
        http_method    = "HEAD"
        port           = 80
        url_path       = "/"
        cycle          = 30
        up_threshold   = 2
        down_threshold = 2
  }
    algorithm_type = "RR"
}

resource "ncloud_lb_target_group_attachment" "target_attach" {
    target_group_no = ncloud_lb_target_group.target.id
    target_no_list  = [ncloud_server.web_server[0].id, ncloud_server.web_server[1].id]
}