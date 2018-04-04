
# Github hub CLI with hub-credential-helper

Container containing https://github.com/github/hub and https://github.com/kelseyhightower/hub-credential-helper for easy usage.

Soon to be alive at https://hub.docker.com/r/norrs/hub/

Please see respective projects at github for documentation for each `hub` and `hub-credential-helper` usage.


# Example usage

## Clone repository

```bash
$ docker run -e HUB_CONFIG=/hub-config -ti -v $HOME/.config/hub-ci:/hub-config hub clone https://github.com/norrs/secret-weapon-killer
```

## Verify credential is filling

```bash
$ docker run -e HUB_CONFIG=/hub-config -ti --entrypoint /bin/sh -v $HOME/.config/hub-zedge-ci:/hub-config hub -c 'git credential fill'
<takes stdin output>
host=github.com
protocol=https
<ctrl+d>
# You should see it fill in some token stuff.. 
```
