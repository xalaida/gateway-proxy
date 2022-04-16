#-----------------------------------------------------------
# Control
#-----------------------------------------------------------

# Include file with .env variables if exists
-include .env

# Define default values for variables
COMPOSE_FILE ?= docker-compose.yml

# Start containers
up:
	docker-compose -f ${COMPOSE_FILE} up -d

# Stop containers
down:
	docker-compose -f ${COMPOSE_FILE} down --remove-orphans

# Build containers
build:
	docker-compose -f ${COMPOSE_FILE} build

# Build and restart containers
update: build up

# Force the update process
update.force:
	docker-compose -f ${COMPOSE_FILE} up -d --build --force-recreate

# Show list of running containers
ps:
	docker-compose -f ${COMPOSE_FILE} ps

# Restart containers
restart:
	docker-compose -f ${COMPOSE_FILE} restart

# Reboot containers
reboot: down up

# View output from containers
logs:
	docker-compose -f ${COMPOSE_FILE} logs

# Show logs of running containers with following output
fl:
	docker-compose -f ${COMPOSE_FILE} logs -f

# Create shared gateway network
network:
	docker network create gateway

# Reload the Nginx service
reload:
	docker-compose -f ${COMPOSE_FILE} exec reverse-proxy nginx -s reload

# Enter the certbot bash session
certbot:
	docker-compose -f ${COMPOSE_FILE} exec certbot /bin/sh

# Init variables for development environment
env.dev:
	cp ./.env.dev ./.env

# Init variables for production environment
env.prod:
	cp ./.env.prod ./.env

# Copy dev stubs into templates folder
copy.stubs.dev:
	cp ./reverse-proxy/dev/stubs/*.conf ./reverse-proxy/dev/sites-enabled/.

# Copy prod stubs into templates folder
copy.stubs.prod:
	cp ./reverse-proxy/prod/stubs/*.conf ./reverse-proxy/prod/sites-enabled/.


#-----------------------------------------------------------
# SSL
#-----------------------------------------------------------

# Issue SSL certificates according to the environment variables
ssl.cert:
	docker-compose -f ${COMPOSE_FILE} run --rm --no-deps \
		--publish 80:80 \
		certbot \
		certbot certonly \
		--domains ${LETSENCRYPT_DOMAINS} \
		--email ${LETSENCRYPT_EMAIL} \
		--agree-tos \
		--no-eff-email \
		--standalone

# Issue testing SSL certificates according to the environment variables
ssl.cert.test:
	docker-compose -f ${COMPOSE_FILE} run --rm --no-deps \
		--publish 80:80 \
		certbot \
		certbot certonly \
		--domains ${LETSENCRYPT_DOMAINS} \
		--email ${LETSENCRYPT_EMAIL} \
		--agree-tos \
		--no-eff-email \
		--standalone \
		--dry-run

# Issue staging SSL certificates according to the environment variables
ssl.cert.staging:
	docker-compose -f ${COMPOSE_FILE} run --rm --no-deps \
		--publish 80:80 \
		certbot \
		certbot certonly \
		--domains ${LETSENCRYPT_DOMAINS} \
		--email ${LETSENCRYPT_EMAIL} \
		--agree-tos \
		--no-eff-email \
		--standalone \
		--staging

# Generate a 2048-bit DH parameter file
ssl.dh:
	sudo openssl dhparam -out ./reverse-proxy/prod/ssl/dhparam.pem 2048

# Show the list of registered certificates
ssl.ls:
	docker-compose -f ${COMPOSE_FILE} run --rm --entrypoint "certbot certificates" certbot


#-----------------------------------------------------------
# Swarm
#-----------------------------------------------------------

# Deploy the stack
swarm.deploy:
	docker stack deploy --compose-file ${COMPOSE_FILE} gateway

# Remove/stop the stack
swarm.rm:
	docker stack rm gateway

# List of stack services
swarm.services:
	docker stack services gateway

# List the tasks in the stack
swarm.ps:
	docker stack ps gateway


#-----------------------------------------------------------
# Bench
#-----------------------------------------------------------

# Live stream a container’s runtime metrics
stats:
	docker stats

# Run benchmarking over the gateway (requires Apache Bench tool: apt-get install -y apache2-utils)
bench:
	ab -c 50 -n 5000 http://localhost/

