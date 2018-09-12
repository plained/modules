resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucketname}"
  tags {
    env = "${var.env}"
    group = "${var.group}"
    hostnames = "${var.bucketname}"
    "aetn:s3securitytemplate" = "testmodule"
    "aetn:env" = "${var.env}"
    "aetn:group" = "${var.group}"
    "aetn:dataConsumer" = "fastly"
    "aetn:cdn" = "${var.group == "sre" ? "fastly" : "akamai" }"
    "aetn:dataOrigin" = "${var.dataOrigin}"
  }


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "${var.sse_algorithm}"
      }
    }
  }

  policy = "${data.template_file.bucketPolicy.rendered}"
}
