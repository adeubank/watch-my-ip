# Watch My IP

Fetches the public IP address from http://whatismyip.akamai.com and posts a slack message if it changes.


## Quickstart

Need to start by creating a new bot and grabbing the API token. https://my.slack.com/services/new/bot

The only dependency is docker. Find the right version for you based on your platform. https://docs.docker.com/engine/installation/.

```
$ cp .env.example .env
$ # add Slack API token to .env file
$ ./build
$ ./watch-my-ip
```

Of course you can update and tweak how you interact with the container. The `build` and `watch-my-ip` script are there just for out of the box convenience.

### Notes

Made to check my IP address at varying times so that I can update the IP addresses to my home PC. All to avoid having to pay for a static IP address.

Here is the crontab entry on Linux server. It runs every minute. Just be sure to pass the correct filepath.

```
* * * * * /path/to/watch-my-ip/watch-my-ip >> /var/log/watch-my-ip.log 2>&1
```
