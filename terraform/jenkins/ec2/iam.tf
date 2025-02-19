resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-master-iam"
  role = "Jenkins_with_ECS_slave"
}

