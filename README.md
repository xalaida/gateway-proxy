[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct-single.svg)](https://stand-with-ukraine.pp.ua)

# Installation

**Step 1.** Copy the `.env.prod` file to the `.env` file and edit it according to your needs.

```
# List all your domains for which you want to issue SSL certificates
LETSENCRYPT_DOMAINS=example.com,www.example.com,api.example.com

# Specify your email
LETSENCRYPT_EMAIL=example@mail.com

# Indicates if it is a staging environemt
LETSENCRYPT_STAGING=false
```

**Step 2.** Create gateway network. 

It will be used in all proxied services.

```bash
docker network create gateway
```

**Step 3.** Issue certificate.

To verify that everything is set up correctly before generating the actual certificate, run the command:

```bash
make ssl.cert.test
```

Then, if you see the message "The dry run was successful.", issue the actual certificate using the command:

```
make ssl.cert
```

**Step 4.** Generate `dhparam` file.

```bash
make ssl.dh
```

**Step 5.** Create templates for desired hosts.

**Step 6.** Build containers.

```bash
make build
```

**Step 7.** Start containers.

```bash
make up
```

## Links

- https://github.com/docker-library/docs/tree/master/nginx
- https://eff-certbot.readthedocs.io/en/stable/install.html#running-with-docker
