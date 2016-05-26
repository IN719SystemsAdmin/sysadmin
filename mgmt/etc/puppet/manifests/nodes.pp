node base{
package { 'vim': ensure => present }
package { 'mc': ensure => present }
include sudo
}
node 'db.micro-agents.net' inherits base
{
include mysql,bacula-file
}
node 'mgmt.micro-agents.net' inherits base
{
include nagios,bacula-director,bacula-file
}
node 'storage.micro-agents.net' inherits base
{
include bacula-storage,bacula-file
}
node 'app' inherits base
{
include bacula-file
}
node 'ad.directory.micro-agents.net'
{

} 
