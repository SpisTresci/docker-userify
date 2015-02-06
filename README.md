# docker-userify, Automated Build Repository

[![nodesource/node](http://dockeri.co/image/spistresci/userify)](https://registry.hub.docker.com/u/spistresci/userify/)

This is an dockerized [enterprise version of Userify](https://userify.com/enterprise/). It was prepared to be used together with other containers: mailserver, database and data-only container.

	git clone https://github.com/SpisTresci/docker-userify.git
	cd docker-userify
	echo '{"Your": "License"}' > license.json
	fig up
	# wait a 30 seconds and open your browser - https://localhost/
	# login: admin, password: admin@yourco.com
