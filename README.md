# Installation

**Step 1.** Create the `.env` file from the `.env.prod` file.

Edit the file according to your needs.

```
# List all your domains for which you want to issue SSL certificates
LETSENCRYPT_DOMAINS=example.com,www.example.com,api.example.com

# Specify your email
LETSENCRYPT_EMAIL=example@mail.com

# Indicates if it is a staging environemt
LETSENCRYPT_STAGING=false
```

**Step 2.** Create gateway network. 

It will be used for all proxied services.

```bash
make gateway
```

**Step 3.** Issue certificate.

**Step 4.** Generate `dhparam` file.

```bash
make ssl:dh
```

**Step 5.** Create templates for desired hosts.

**Step 6.** Build and start containers.

```bash
make build
```

**Step 7.** Start containers.

```bash
make up
```


# TODO

- [ ] add install script
- [ ] www redirect to non-www
- [ ] use staging env variable
- [ ] add command to reissue cert according to new params
- [ ] first time generate cert using `--dry-run` option to ensure everything is ok
- [ ] add possibility to automatically generate conf from stub (default nginx template engine very often breaks with variables inside strings)
- [ ] generate overlay network for swarm
- [ ] configure logging
  - [ ] probably disable access.log
  - [ ] forward nginx logs from nginx.conf into /std/err
  - [ ] add logrotate 
  - [ ] forward letsencrypt logs to docker collector
  - [ ] integrate with prometheus
- [ ] add dev env
    - filling /etc/hosts
    - generate local cert (?)


## Links

- https://github.com/docker-library/docs/tree/master/nginx
- https://eff-certbot.readthedocs.io/en/stable/install.html#running-with-docker
