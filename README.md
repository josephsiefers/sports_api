# README

Import players:
docker-compose run sports_api_dev bundle exec rake db:create
docker-compose run sports_api_dev bundle exec rake db:migrate
docker-compose run sports_api_dev script/import_players.rb

Bring up server:
docker-compose up sports_api_dev

(Requires port 8080 and 3307 to be available)

View JSON output:

http://localhost:8080/players/?type=football
http://localhost:8080/players/?type=baseball
http://localhost:8080/players/?type=basketball