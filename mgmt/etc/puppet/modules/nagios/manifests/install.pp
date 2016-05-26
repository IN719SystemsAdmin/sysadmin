class nagios::install {
  package { "nagios3" :
            ensure => present,
          }
}
