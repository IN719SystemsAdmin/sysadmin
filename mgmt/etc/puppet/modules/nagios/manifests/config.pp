class nagios::config {
  file { "/etc/nagios3/nagios.cfg":
         ensure => present,
         source => "puppet:///modules/nagios/nagios.cfg",
         mode => 0444,
         owner => "nagios",
         group => "nagios",
         require => Class["nagios::install"],
         notify => Class["nagios::service"],
       }
  nagios_contact { 'ongs2':
                   target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
                   alias => 'Jacob',
                   service_notification_period => '24x7',
                   host_notification_period => '24x7',
                   service_notification_options => 'w,u,c,r',
                   host_notification_options => 'd,r',
                   service_notification_commands => 'notify-service-by-email',
                   host_notification_commands => 'notify-host-by-email',
                   email => 'ongs2@student.op.ac.nz',
                 }

nagios_contact { 'vakalik1':
                   target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
                   alias => 'Ili',
                   service_notification_period => '24x7',
                   host_notification_period => '24x7',
                   service_notification_options => 'w,u,c,r',
                   host_notification_options => 'd,r',
                   service_notification_commands => 'notify-service-by-email',
                   host_notification_commands => 'notify-host-by-email',
                   email => 'vakalik1@student.op.ac.nz',
                 }

nagios_contact { 'thomjr5':
                   target => '/etc/nagios3/conf.d/ppt_contacts.cfg',
                   alias => 'Josh',
                   service_notification_period => '24x7',
                   host_notification_period => '24x7',
                   service_notification_options => 'w,u,c,r',
                   host_notification_options => 'd,r',
                   service_notification_commands => 'notify-service-by-email',
                   host_notification_commands => 'notify-host-by-email',
                   email => 'thomjr5@student.op.ac.nz',
                 }

  nagios_contactgroup { 'sysadmins':
                        target => '/etc/nagios3/conf.d/ppt_contactgroups.cfg',
                        alias => 'Systems Administrators',
                        members => 'ongs2,vakalik1,thomjr5',
                      }

  nagios_host { 'storage.micro-agents.net':
		target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
		alias => 'storage',
		address => '10.25.1.96',
		check_period => '24x7',
		max_check_attempts => 3,
		check_command => 'check-host-alive',
		notification_interval => 30,
		notification_period => '24x7',
		notification_options => 'd,u,r',
		contact_groups => 'sysadmins',
		}
  nagios_host { 'db.micro-agents.net':
                target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
                alias => 'db',
                address => '10.25.1.99',
                check_period => '24x7',
                max_check_attempts => 3,
                check_command => 'check-host-alive',
                notification_interval => 30,
                notification_period => '24x7',
                notification_options => 'd,u,r',
                contact_groups => 'sysadmins',
               }
nagios_host { 'app.micro-agents.net':
               target => '/etc/nagios3/conf.d/ppt_hosts.cfg',
	       alias => 'app',
	       address => '10.25.1.95',
	       check_period => '24x7',
	       max_check_attempts => 3,
	       check_command => 'check-host-alive',
	       notification_interval => 30,
	       notification_period => '24x7',
	       notification_options => 'd,u,r',
	       contact_groups => 'sysadmins',
    	}

  nagios_service {'MySQL':
                  service_description => 'MySQL DB',
                  hostgroup_name => 'db-servers',
                  target => '/etc/nagios3/conf.d/ppt_mysql_service.cfg',
                  check_command => 'check_mysql_cmdlinecred!$USER3$!$USER4$',
                  max_check_attempts => 3,
                  retry_check_interval => 1,
                  normal_check_interval => 5,
                  check_period => '24x7',
                  notification_interval => 30,
                  notification_period => '24x7',
                  notification_options => 'w,u,c',
                  contact_groups => 'sysadmins',
                 }
 nagios_service {'check_remote_disks':
                  service_description => 'disk check for remote servers',
                  hostgroup_name => 'remote-disk-check',
                  target => '/etc/nagios3/conf.d/ppt_nrpe_service.cfg',
                  check_command => 'check_nrpe_1arg!check_hd',
                  max_check_attempts => 3,
                  retry_check_interval => 1,
                  normal_check_interval => 5,
                  check_period => '24x7',
                  notification_interval => 30,
                  notification_period => '24x7',
                  notification_options => 'w,u,c',
                  contact_groups => 'sysadmins',
                }
  nagios_hostgroup{'db-servers':
                   target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
                   alias => 'Database Servers',
                   members => 'db.micro-agents.net',
                  }
  nagios_hostgroup{'remote-disk-check':
		   target => '/etc/nagios3/conf.d/ppt_hostgroups.cfg',
		   alias => 'Remote Servers',
		   members => 'storage.micro-agents.net,db.micro-agents.net,app.micro-agents.net',
		  }
}
