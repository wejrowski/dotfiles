require 'rake'

#https://github.com/zsh-users/zsh-completions
desc "symlink dot files into home directory"
task :install do
  install_janus
  install_oh_my_zsh
  switch_to_zsh
  install_bash_completion
  relink_files
end

desc "relink main dotfiles"
task :relink do
  relink_files
end

def relink_files
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.md]
  files.each do |file|
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
        if replace_all
          replace_file(file)
        else
          print "overwrite ~/.#{file}? [ynaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_file(file)
          when 'y'
            replace_file(file)
          when 'q'
            exit
          else
            puts "skipping ~/.#{file}"
          end
        end
    else
      link_file(file)
    end
  end
end

def replace_file(file)
  puts "removing ~/.#{file}"
  system %Q{rm -rf "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system "ln -s $PWD/#{file} $HOME/.#{file}"
end

def install_janus
  if File.exist?(File.join(ENV['HOME'], ".vim"))
    puts "skipping Janus install -- you already have a ~/.vim directory"
  else
    print "install janus? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing Janus"
      system %Q{ curl -Lo- https://bit.ly/janus-bootstrap | bash } #https://github.com/carlhuda/janus
    when 'q'
      exit
    else
      puts "skipping Janus .vim installation"
    end
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end
