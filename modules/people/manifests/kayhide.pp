class people::kayhide {
  include keyremap4macbook
  include better_touch_tools
  include alfred
  include iterm2::stable
  include emacs
  include chrome
  include dropbox
  include evernote
  include skype
  include picasa

  package {
    [
     'tmux',
     'reattach-to-user-namespace',
     'tig',
     'cmigemo',
     'lv'
     ]:
  }

  #ricty font
  homebrew::tap { 'sanemat/font': }
  package { 'sanemat/font/ricty':
    require => Homebrew::Tap["sanemat/font"]
  }
  exec { 'set ricty':
    command => "cp -f ${homebrew::config::installdir}/share/fonts/Ricty*.ttf ~/Library/Fonts/ && fc-cache -vf",
    require => Package["sanemat/font/ricty"]
  }

  package { 'zsh':
    install_options => ['--disable-etcdir']
  }
  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
    before  => Osx_chsh[$::luser];
  }
  exec { 'chenge shell to zsh':
    command => "chsh -s ${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh']
  }
}
