FROM phusion/passenger-ruby23:0.9.30 as base

RUN apt-get update && apt-get install -y tzdata --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#This hack prevents bundle install from taking forever except when changes are made
#to the Gemfile
#Gems are still installed in the regular gemdir (/usr/local/rvm/gems/ruby-2.2.5)
WORKDIR /tmp

COPY --chown=app:app Gemfile /tmp
COPY --chown=app:app Gemfile.lock /tmp/Gemfile.lock

FROM base as prod

RUN bundle install --without development test

#preserve bundler exclude settings at bundle exec runtime
RUN mv .bundle/ /home/app/.bundle

WORKDIR /home/app/

#explicitly include items for the production build to cut down on size (and limit unnecessary baggage)
#directories
#COPY --chown=app:app . /home/app/
COPY --chown=app:app ./app/ /home/app/app/
COPY --chown=app:app ./bin/ /home/app/bin/
COPY --chown=app:app ./config/ /home/app/config/
COPY --chown=app:app ./db/ /home/app/db/
COPY --chown=app:app ./public/ /home/app/public
COPY --chown=app:app ./lib/ /home/app/lib/
COPY --chown=app:app ./script/ /home/app/script/

#files
COPY --chown=app:app ./config.ru /home/app/config.ru
COPY --chown=app:app ./Rakefile /home/app/Rakefile
RUN mv /tmp/Gemfile /home/app
RUN mv /tmp/Gemfile.lock /home/app

CMD /sbin/my_init -- bundle exec puma -b tcp://127.0.0.1:8080

#FROM base as test

#RUN bundle install --without development

#RUN mv .bundle /home/app/.bundle

#WORKDIR /home/app/

#COPY --chown=app:app . /home/app

#CMD bundle exec rspec

#FROM test as dev

#RUN bundle install

#WORKDIR /home/app/

#COPY --chown=app:app . /home/app

#CMD /sbin/my_init -- bundle exec puma -b tcp://127.0.0.1:8080