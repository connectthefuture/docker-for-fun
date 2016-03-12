# PAAS4U - Platform As A Service For YOU!

![alt text](https://cloud.githubusercontent.com/assets/6406166/11431151/d94688d6-945f-11e5-9af6-8451d2b3ea85.png)

This project automates a small 2 node paas on Ubuntu 14.04 utilizing a few open sources projects. There are many good projects that have already pieced together these open source projects to create a paas, but I created this project primarily to get a "hands-on" understanding around all the hype around containers, datacenter resource abstractions, clustering, service discovery, scaling etc... being utilized by companies such as twitter and airbnb. 

There are many opensource tools around these services, but I landed on the following for now:

1. Mesos + Marathon   - Used to abstract resources such as cpu, memory, storage and do service orchestration
2. Docker             - Used to provide the "container" services
3. Consul             - Used to provide the service discovery
4. Consul-template    - Used to provide dynamic configuration
5. HaProxy            - Used to provide load balancing and proxy
6. Mesos-Consul       - Used as a bridge between Mesos and Consul for dynamic tasks/service discovery

To me some of these open sources projects still don't feel production ready and I ran into many issues that required some sort of workaround or I simply avoiding using some features. I know some of these products are actually being used in Production, but I am sure they must have an army of really good devops folks and possibly many scripts to help fix and/or heal issues.

I kept this small, so that it functions fine running on a laptop with limited resources and primarily used for testing and learning. There is only a quorum of 1 for mesos masters and consul servers as well.

This build will pull whatever latest builds that are available in the mesosphere repos for mesos, marathon, chronos and zookeeper and also the latest docker versions that are used to run containers on the mesos slaves.  

## Installation

### Pre-req

1. Ensure you have vagrant installed
2. Ensure you have virtualbox installed
3. Ensure you have ansible installed

Note: This may not work on windows dev machines because I believe the ansible provisioners won't run on windows, but not 100% sure. This should work fine on a mac or linux machine. 

### O.K enough already, how do I RUN IT?

Clone the project to a directory of your choice

``` 
   git clone https://github.com/sarlindo/paas4u
```

change into the pass4u directory

```
   cd paas4u
```

bring up pass4u

```
   vagrant up
```
 
## Usage


#### The following are the URL's for the individual Web UI applications

```
http://marathon.192.168.33.10.xip.io                 (this is the Web UI for marathon, you can use this UI to launch new applications)
http://mesos.192.168.33.10.xip.io                    (this is the Web UI for mesos, you can use this UI to check on your mesos cluster's resources)
http://chronos.192.168.33.10.xip.io                  (this is the Web UI for chronos, you can use this UI to schedule jobs in mesos, like cron)
http://servicediscovery.192.168.33.10.xip.io         (this is the Web UI for consul, you can use this UI to see all services in your registry)


http://python.192.168.33.10.xip.io                   (this is the Web UI for a sample python web server)
http://wildfly.192.168.33.10.xip.io/node-info        (this is the Web UI for a sample jboss/wildfly JEE app)
```

## Troubleshooting


All logs for marathon, mesos-master, mesos-slave and chronos will go into 

```
/var/log/mesos
```

All logs for docker containers can be inspected with the command 

```
sudo docker logs <containerid>
```

## TO-DO

1. clean up the ansible roles to remove some hardcoding
2. add in jenkins to attempt continuous integration and deployment
3. add in vault to play with secrets
4. add in kubernetes as a framework into mesos
5. add windows dev machine support with ansible
6. add new frontend to allow multi-tenancy, where developers only see what app they created and isolated from other teams
7. play with linking containers, swarm?
8. add some sort of central logging
9. add some sort of monitoring
10. Authentication & Authorization
