#! /bin/bash
yum -y install git rubygem-bundler rubygem-rake ruby-devel rubygems gcc libxml2-devel libxml2 libvirt-devel sqlite-devel gcc-c++
cd /opt
([ -d /opt/foreman ] && [ -d /opt/foreman/.git ]) || git clone https://github.com/theforeman/foreman.git && cd /opt/foreman/ && git checkout develop
cd /opt/foreman
[ -f config/database.yml ] || cp config/database.yml.example config/database.yml
[ -f config/settings.yaml ] || cp config/settings.yaml.example config/settings.yaml
sed -i  's/\:login\: true/\:login\: false/g' config/settings.yaml
bundle install --without postgresql mysql2 --path vendor/gems
if ! [ -f .seeded ]; then
  bundle exec rake db:migrate
  bundle exec rake db:seed
  touch .seeded
fi
bundle exec rails server &
