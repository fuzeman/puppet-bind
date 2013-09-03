# = Define: bind::acl

define bind::acl (
  $absent         = false,
  $addresses   = '',
) {
  $bool_absent = any2bool($absent)

  include bind
  include concat::setup

  if $bool_absent == false {
    # Register this subnet file into main configuration
    concat::fragment {"bind-include-acl-${name}":
      target  => $bind::config_file,
      content => template( 'bind/named.conf-acl.erb' ),
      order   => 30,
    }
  }
}
