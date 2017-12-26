# == Class: kubernetes::master::controller_manager
# http://kubernetes.io/docs/admin/kube-controller-manager/
#
class kubernetes::controller_manager (
  $ensure       = true,
  $enable       = true,
  $api_key_path = '/tmp/serviceaccount.key',
) {
  include kubernetes::master

  case $::osfamily {
    'redhat' : {
    }
    'debian' : {
      file { '/etc/default/kube-controller-manager':
        ensure  => 'file',
        force   => true,
        content => epp("kubernetes/etc/kubernetes/controller-manager.epp"),
        notify  => Service['kube-controller-manager'],
      }
    }
    default  : {
      fail("Unsupport OS: ${::osfamily}")
    }
  }

  file { '/etc/kubernetes/controller-manager':
    ensure  => 'file',
    force   => true,
    content => epp("kubernetes/etc/kubernetes/controller-manager.epp"),
    notify  => Service['kube-controller-manager'],
  }

  service { 'kube-controller-manager':
    ensure => $ensure,
    enable => $enable,
  }
}
