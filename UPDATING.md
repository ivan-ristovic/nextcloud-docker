# Updating

How to update:
- Stop the containers: `docker-compose down`
- Update the `NEXTCLOUD_VERSION` in `.env` file to the **immediately next** major version (nextcloud **does not support updating over multiple major versions**)
    - Repeat this for every major version
- Rebuild the images: `docker-compose pull && docker-compose build`
- Start the containers: `docker-compose up -d && docker-compose logs -f`


## Troubleshooting
- If the update keeps the instance in maintenance mode, hop into the container:
```bash
$ docker exec -it nextcloud-docker-container-1 /bin/bash
root@container $ sudo -u www-data ./occ upgrade   # or whatever, to disable maintenance
```
