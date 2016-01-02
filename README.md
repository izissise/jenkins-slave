Jenkins Slave
=============

[Docker][1] container to build Jenkins projects inside.  

Recommanded usage:  
```
docker run --name jenkins-slave -v /var/run/docker.sock:/run/docker.sock -v $(which docker):/bin/docker izissise/jenkins-slave  
```
[1]: http://docker.io
