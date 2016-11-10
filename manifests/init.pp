# Install virtualbox on windows.
class wmf(
  $version     = $wmf::params::version,
  $temp_folder = $wmf::params::temp_folder
  ) inherits wmf::params {

  if ! has_key($wmf::params::urls, "${version}") {
    fail "This version of WMF is not supported: ${version}"
  }

  if ! has_key($wmf::params::urls["${version}"], $::operatingsystemrelease) {
    fail "This OS (${::operatingsystemrelease}) is not supported for WMF ${version}"
  }

  $download_url = $wmf::params::urls["${version}"][$::operatingsystemrelease]
  $kb_number = $download_url.match(/(KB\d+)/)[1]

  ensure_resource('file', $temp_folder, { ensure => directory })

  file { "${temp_folder}/wmf_${version}.msu":
    ensure => 'present',
    source => $download_url,
  }
  ->
  exec { "Install WMF ${version}":
    command => "wusa.exe \"${temp_folder}/wmf_${version}.msu\" /quiet /norestart /log:\"${temp_folder}/wmf_${version}.msu.log.txt\"",
    returns => [0, 3010],
    unless  => "cmd.exe /c wbem\\wmic qfe | findstr ${kb_number}",
    path    => 'C:/Windows/System32/',
  }
  ~>
  reboot { "Reboot after WMF ${version}":
    when => pending,
  }

}
