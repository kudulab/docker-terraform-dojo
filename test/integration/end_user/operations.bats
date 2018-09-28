load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "ide init finished"
  assert_line --partial "/ide/work"
  assert_line --partial "terraformide"
  refute_output --partial "IMAGE_VERSION"
  refute_output --partial "root"
  assert_equal "$status" 0
}
@test "correct terraform version is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"terraform --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Terraform v0.11.10"
  assert_equal "$status" 0
}
@test "openstack env variables are preserved" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"env | grep OS_ | grep -v OS_PASSWORD\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "OS_USERNAME"
  assert_equal "$status" 0
}
@test "any dot version is installed (graphviz)" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"dot -V\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "dot - graphviz version"
  assert_equal "$status" 0
}
@test "dot can generate png file without error" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"dot -Tpng graph1.gv -o graph1.png\""
  # this is printed on test failure
  echo "output: $output"
  assert_equal "$status" 0
}
@test "ssh client is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"ssh\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "usage: ssh"
  assert_equal "$status" 255
}
@test "curl is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"curl --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "curl"
  assert_equal "$status" 0
}
@test "git is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"git --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_output --partial "git version"
  assert_equal "$status" 0
}
# when running the first time in the terraform directory, you have to run
# `terraform init`, so that it creates lock.json file
@test "terraform plugins are installed - openstack vm and null_resource" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"cd openstack_vm && terraform plan\""
  # this is printed on test failure
  echo "output: $output"
  refute_output --partial "error"
  refute_output --partial "no suitable version installed"
  assert_equal "$status" 0
}
@test "jq is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"jq\""
  # this is printed on test failure
  echo "output: $output"
  assert_output --partial "jq is a tool for processing JSON"
  assert_equal "$status" 2
}
