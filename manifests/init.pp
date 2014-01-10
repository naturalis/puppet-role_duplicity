# == Class: role_duplicity
#
#
class role_duplicity (  
  $directories = ['/etc','/tmp/backup','/home'],
  $bucket = 'linuxbackups',
  $dest_id,
  $dest_key,
  $cloud = 's3',
  $hour = 1,
  $minute = 1,
  $full_if_older_than = 30,
  $pre_command = undef,
  $remove_older_than = 31) {

  duplicity { 'backupjob':
    directories         => $directories,
    folder              => '',
    bucket              => $bucket,
    dest_id             => $dest_id,
    dest_key            => $dest_key,
    cloud               => $cloud,
    hour                => $hour,
    minute              => $minute,
    remove_older_than   => $remove_older_than,
    full_if_older_than  => $full_if_older_than,
    pre_command         => $pre_command,
  }

  file { "/tmp/backup":
    ensure       => 'directory',
    mode         => '0700',
  }
}
