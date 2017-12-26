# == Class: kubernetes::node
#
# Module to install an up-to-date version of kubernetes::node from package.
#
# === Parameters
#
# [*manage_package*]
#   if you want to install the software from a package.
#   Defaults to true
#
# [*ensure*]
#   Passed to the kubernetes::node package.
#   Defaults to present
#
class kubernetes::node (
  $manage_package = true,
  $ensure         = 'present',
  $kube_master    = 'http://localhost:8080',
) {

  file { '/etc/kubernetes/config':
    ensure  => file,
    content => epp("kubernetes/etc/kubernetes/config.epp"),
    require => Package['kubernetes-node'],
  }

  if $manage_package {
    package { ['kubernetes-node']: ensure => $ensure, } ->
    file { '/var/run/kubernetes/':
      ensure => directory,
      owner  => 'kube',
    }
  }
}
