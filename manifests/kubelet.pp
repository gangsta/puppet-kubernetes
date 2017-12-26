# == Class: kubernetes::node::kubelet
# http://kubernetes.io/docs/admin/kubelet/
#
# Module to install an up-to-date version of kubelet from package.
#
# === Parameters
#
# [*ensure*]
#   Whether you want to kubelet daemon to start up
#   Defaults to running
#
# [*journald_forward_enable*]
#   Fix for SIGPIPE sent to registry daemon during journald restart
#   Defaults to false
#
#
class kubernetes::kubelet (
  $kubelet_address    = '127.0.0.1',
  $kubelet_hostname   = "$::fqdn",
  $kubelet_api_server = 'http://localhost:8080',
  $ensure             = true,
  $enable             = true,
){
  include ::kubernetes::node

  case $::osfamily {
    'redhat' : {
    }
    'debian' : {
      file { '/etc/default/kubelet':
        ensure  => 'file',
        force   => true,
        content => template("kubernetes/etc/default/kubelet.erb"),
      } ~> Service['kubelet']
    }
    default  : {
      fail("Unsupport OS: ${::osfamily}")
    }
  }

  file { '/etc/kubernetes/kubelet':
    ensure  => 'file',
    content => epp("kubernetes/etc/kubernetes/kubelet.epp"),
  } ~> Service['kubelet']

  service { 'kubelet':
    ensure => $ensure,
    enable => $enable,
  }
}
