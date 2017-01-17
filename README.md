<h1>Teamladders Docker Environment</h1>


Syntax: make RULE

<pre>
Rules list:
help:       shows a list of commands
dbs:        makes databases for application
build:      builds (or rebuilds) containers, copies all configure files from conf directory
start:      starts containers with current configuration from conf directory
stop:       stops containers
restart:    restarts containers
rm:         stops and removes containers
status:     containers status
postgres:   Postgres container bash
redis:      Redis container bash
nginx:      NGINX container bash
app:        Main application container
</pre>

You can specify custom location for persistent stuff (config files, database files) via env variable `TEAMLADDERS_STORAGE_ROOT`. Default value is `/var/docker/env_teamladders`.
