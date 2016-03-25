# Create container
```
docker run -it -d --name=samba -h=samba -p 445:445 -p 1001:22 trixmc/samba /bin/bash
```

# SSH
```
ssh -p1001 root@localhost
password: root
```

# etcKeeper 
Added etcKeeper - autocommit on exit to /etc git local repository

# Origin
[Docker Hub] (https://registry.hub.docker.com/u/trixmc/samba)

[Git Hub] (https://github.com/trixmc/samba)
