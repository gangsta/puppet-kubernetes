# Class: kubernetes::client
#
# This module manages kubernetes-client package.
# It only populates the /etc/kubernetes/config file: it empties all variables.
#
# Parameters:
#
# [*manage_package*]
#   If the module should take care of installing the package
#   Defaults to true
#
# [*ensure*]
#   Set package version to be installed or use 'installed'/'latest'
#   Defaults to installed
#
#
class kubernetes::client (
  $manage_package = true,
  $ensure         = 'present',
) {
  # /etc/kubernetes/config is managed by both master and node rpms
  # so we take care of it here
  validate_string($ensure)

  if $manage_package {
    package { 'kubernetes-client': ensure => $ensure, }
  }
}
