resource "ncloud_lb" "lb_app" {
  name = "${var.name}-lb"
  network_type = "PUBLIC"
  type = "APPLICATION"
  subnet_no_list = [ncloud_subnet.subnet3.id]
}

resource "ncloud_lb_listener" "lb_http" {
  load_balancer_no  = ncloud_lb.lb_app.id
  protocol          = "HTTP"
  port              = 80
  target_group_no   = ncloud_lb_target_group.target.id
}

resource "ncloud_lb_listener" "lb_https" {
  load_balancer_no    = ncloud_lb.lb_app.id
  protocol            = "HTTPS"
  port                = 443
  target_group_no     = ncloud_lb_target_group.target.id
  ssl_certificate_no  = 9920
}