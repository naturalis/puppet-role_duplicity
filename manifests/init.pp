# == Class: role_duplicity
#
# Full description of class role_duplicity here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { role_duplicity:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class role_duplicity (  
  $directories = ['/etc','/var/www','/home'],
  $bucket = 'linuxbackups',
  $dest_id,
  $dest_key,
  $cloud = 's3',
  $hour = 1,
  $minute = 1,
  $full_if_older_than = 30,
  $pre_command = undef,
  $remove_older_than = 31) {

  define backuplink {
    file { "/tmp${name}":
      ensure              => link,
      target              => $name,
    }
  }

  backuplink { $directories: }

  duplicity { 'backupjob':
    directory           => '/tmp/backup',
    folder              => '',
    bucket              => $bucket,
    dest_id             => $dest_id,
    dest_key            => $dest_key,
    cloud               => $cloud,
    hour                => $backuphour,
    minute              => $backupminute,
    remove_older_than   => $remove_older_than,
    full_if_older_than  => $full_if_older_than,
    pre_command         => $precommand,
  }

}
