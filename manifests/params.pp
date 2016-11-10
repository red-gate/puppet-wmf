# PRIVATE CLASS: do not use directly
class wmf::params {
  $version    = '5.0'

  $temp_folder = 'c:/windows/temp'

  $urls = {
    '5.0' => {
      '2012' => 'https://download.microsoft.com/download/2/C/6/2C6E1B4A-EBE5-48A6-B225-2D2058A9CEFB/W2K12-KB3134759-x64.msu',
      '2012 R2' => 'https://download.microsoft.com/download/2/C/6/2C6E1B4A-EBE5-48A6-B225-2D2058A9CEFB/Win8.1AndW2K12R2-KB3134758-x64.msu',
    },
    '5.1' => {
      '2012' => 'TODO',
      '2012 R2' => 'TODO',
    }
  }
}
