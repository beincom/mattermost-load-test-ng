# reset database
```shell
PGPASSWORD=mostest psql --username=mmuser --dbname=mattermost_test --host=localhost --set ON_ERROR_STOP=on -c "drop schema public cascade; create schema public;"
PGPASSWORD=mostest pg_restore --username=mmuser --dbname=mattermost_test --host=localhost --verbose ~/beincom/chat/doc/dump-mattermost_test-202306011537-clean-with=sysadmin
```

# init
- to create admins, users, we need to create sysadmin
```shell
mmctl  user create --system-admin --email sysadmin@sample.mattermost.com --password=Sys@dmin-sample1 --username=sysadmin --local
```
- create users, posts
```shell
ltagent init
```

