# PlasticSCM Docker tooling

## Using Docker Compose
To build:
```
docker-compose -f docker-compose.yaml build plastic
```
To run:
```
docker-compose -f docker-compose.yaml up -d plastic
```

To add a user: `PLASTIC, PLEASE UPDATE, I DON'T KNOW THIS`

To refresh the server: `PLASTIC, PLEASE UPDATE, I DON'T KNOW THIS`


#### The next three instructions assume you are looking at directory in which you cloned this repository.
* To upload a new license file: replace the file named `plasticd.lic` in the `data/conf` directory
* To backup the databases: copy the files from the `data/sqlite` directory
* To retrieve logs: copy the files from the `data/logs` directory


## Classic mode
To build:

    docker build --rm=true -t <image_name> plastic -f Dockerfile.14

To run:

    docker run --name plastic_data <image_name> echo "My data container"
    docker run -d -P --name plastic_server --volumes-from plastic_data <image_name>

To add a user:

    docker run --rm --volumes-from plastic_data <image_name> umtool cu <user_name> <user_password>

To refresh the server:

    docker restart plastic_server

To upload a new license file:

    docker run --rm --volumes-from plastic_data -v $(pwd):/newlicense <image_name> cp /newlicense/plasticd.lic /config

To backup the databases:

    mkdir backup
    docker run --rm --volumes-from plastic_data -v $(pwd)/backup:/backup <image_name> tar cvf /backup/databases_backup_$(date).tar /db/sqlite

To retrieve logs:

    # Console
    docker logs plastic_server
    # Files
    mkdir /log_backup
    docker run --rm --volumes-from plastic_data -v $(pwd)/logs:/log_backup <image_name> tar cvf /log_backup/logs_$(date).tar /logs
