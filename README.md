Linda Skype
===========
send skype message with [linda-socket.io](https://github.com/node-linda/linda-socket.io)

- https://github.com/node-linda/ruby-linda-skype
- watch {type: "skype", cmd: "send"}
  - write {type: "skype", cmd: "send", value: "~~~", response: "success"}


## Dependencies

- Skype
- Mac or Linux
- Ruby 1.9.3~2.0.0


## Install Dependencies

    % gem install bundler
    % bundle install


## Run

to the chat which topic matches /linda/

    % CHAT_TOPIC=linda foreman start

=> http://node-linda-base.herokuapp.com/test?type=skype&cmd=send&value=hello


## Run with your [linda-base](https://github.com/node-linda/node-linda-base)

    % export LINDA_BASE=http://node-linda-base.herokuapp.com
    % export LINDA_SPACE=test
    % export CHAT_TOPIC='linda chat'
    % foreman start


## Install as Service

    % gem install foreman

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app ruby-linda-skype -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/ruby-linda-skype-main-1.plist


for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app ruby-linda-skype -d `pwd` -u `whoami`
    % sudo service ruby-linda-skype start
