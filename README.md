<h1>Teamladders Docker Environment</h1>


Syntax: make RULE

<pre>
Rules list:
help:       shows a list of commands
set:        set custom environment parameters
dbs:        makes databases for application
cpconfigs:  copy configs to environment directory
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

<b>Before starting the work execute `make set` to make environment configuration file.</b>
