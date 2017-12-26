# == Class: kubernetes::master::apiserver
# http://kubernetes.io/docs/admin/kube-apiserver/
#
# [*extra_args*]
#   Set your own
#   Default undef
#
class kubernetes::apiserver (
  $kube_service_addresses = '10.254.0.0/16',
  $kube_etcd_servers      = 'http://127.0.0.1:2379',
  $kube_api_address       = '127.0.0.1',
  $api_key_path           = '/tmp/serviceaccount.key',
  $ensure                 = true,
  $enable                 = true,
) {
  include kubernetes::master

  case $::osfamily {
    'redhat' : {
    }
    'debian' : {
      file { '/etc/default/kube-apiserver':
        ensure  => 'file',
        force   => true,
        content => template("kubernetes/etc/default/api-server.erb"),
        notify  => Service['kube-apiserver'],
      }
    }
    default  : {
      fail("Unsupport OS: ${::osfamily}")
    }
  }

  file { '/etc/kubernetes/apiserver':
    ensure  => 'file',
    content => epp("kubernetes/etc/kubernetes/apiserver.epp"),
    notify  => Service['kube-apiserver'],
  }

  service { 'kube-apiserver':
    ensure => $ensure,
    enable => $enable,
  }
}
