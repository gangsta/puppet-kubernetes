# == Class: kubernetes::node::kube_proxy
# http://kubernetes.io/docs/admin/kube-proxy/
#
#
class kubernetes::kube_proxy {
#
#      case $::osfamily {
#        'redhat' : {
#        }
#        'debian' : {
#          file { '/etc/default/kube-proxy':
#            ensure  => 'file',
#            force   => true,
#            content => template("${module_name}/etc/default/proxy.erb"),
#            notify  => Service['kube-proxy'],
#          }
#        }
#        default  : {
#          fail("Unsupport OS: ${::osfamily}")
#        }
#      }
#
#      file { '/etc/kubernetes/proxy':
#        ensure  => 'file',
#        content => template("${module_name}/etc/kubernetes/proxy.erb"),
#        notify  => Service['kube-proxy'],
#      }
#
  service { 'kube-proxy':
    ensure => $ensure,
    enable => $enable,
  }
}
