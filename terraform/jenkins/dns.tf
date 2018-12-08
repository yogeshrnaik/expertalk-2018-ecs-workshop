data aws_route53_zone "ecs_workshop_hosted_zone" {
  name = "ecsworkshop2018.online."
}

module "dns" {
  source              = "git@github.com:yogeshrnaik/expertalk-2018-ecs-workshop.git//terraform-modules/route53-alias"
  weight              = "100"
  lb_dns_name         = "${module.alb.alb_dns_name}"
  lb_zone_id          = "${module.alb.alb_zone_id}"
  hosted_zone         = "${data.aws_route53_zone.ecs_workshop_hosted_zone.name}"
  dns_record_set_name = "${local.unique}-jenkins.ecsworkshop2018.online"
  env                 = "dev"
  app_name            = "jenkins"
  unique              = "${local.unique}"
}

data "aws_acm_certificate" "jenkins_certificate" {
  domain      = "*.ecsworkshop2018.online"
  statuses    = ["ISSUED"]
  most_recent = true
}
