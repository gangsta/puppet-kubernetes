# == Class: kubernetes::master::config
#
# Module to install an up-to-date version of kubernetes from package.
#
# === Parameters
#
# [*kube_master*]
#   KUBE_MASTER parameter for /etc/kubernetes/config.
#   usage kube_master => 'http://domain.com:8080'
#   Defaults to undef
#
class kubernetes::config (
  $kube_master = 'http://localhost:8080',
) {

  file { '/etc/kubernetes/config':
    ensure  => file,
    content => epp("kubernetes/etc/kubernetes/config.epp"),
    require => Package['kubernetes-master'],
  }
}
