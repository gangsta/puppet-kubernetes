# == Class: kubernetes::master::scheduler
# http://kubernetes.io/docs/admin/kube-scheduler/
#
#TBD
class kubernetes::scheduler  {
#  case $manage_as {
#    'service'   : {
#      include ::kubernetes::master
#
#      case $::osfamily {
#        'redhat' : {
#        }
#        'debian' : {
#          file { '/etc/default/kube-scheduler':
#            ensure  => 'file',
#            force   => true,
#            content => template("${module_name}/etc/default/scheduler.erb"),
#            notify  => Service['kube-scheduler'],
#          }
#        }
#        default  : {
#          fail("Unsupport OS: ${::osfamily}")
#        }
#      }
#
#      file { '/etc/kubernetes/scheduler':
#        ensure  => 'file',
#        force   => true,
#        content => template("${module_name}/etc/kubernetes/scheduler.erb"),
#        notify  => Service['kube-scheduler'],
#      }
#
  service { 'kube-scheduler':
    ensure => true,
    enable => true,
  }
}
