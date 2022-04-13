# Installation

1. Copy `.env.prod` file to `.env`

2. Create gateway network

```
# Make command
make gateway

# Raw command
docker network create gateway
```

# TODO

- [ ] add install.sh
    - make .env
    - network
    - generate ssl certificates
    - generate dh params
    - generate templates from stubs
    - build
    - run
- [ ] www redirect to non-www
- [ ] add staging env variable
- [ ] add possibility to automatically generate conf from stub (default nginx template engine very often breaks with variables inside strings)
- [ ] generate overlay network for swarm
- [ ] configure nginx logging (forward into /std/err, add logrotate)
- [ ] forward letsencrypt logs
- [ ] add dev env
    - filling /etc/hosts
    - generate local cert (?)


## Sources

- https://github.com/docker-library/docs/tree/master/nginx
- https://eff-certbot.readthedocs.io/en/stable/install.html#running-with-docker
