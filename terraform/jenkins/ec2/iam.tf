# Jenkins IAM Policies, Role+Policy Attachements, & the Role itself to attach to Jenkins
# These permissions are currently very liberal, lock this down once you define what your Jenkins instance will do

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-master-iam"
  role = "Jenkins_with_ECS_slave"
}

