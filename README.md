# RPirate-Ship

A collection of [Docker](https://www.docker.com/) containers that eases and automates collecting media such as TV Shows and Movies.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisities

- Raspberry Pi with Docker installed (See [here](http://blog.hypriot.com/getting-started-with-docker-and-linux-on-the-raspberry-pi/) for a ready-made image)
- [Docker Compose](https://docs.docker.com/compose/) (See [here](http://blog.hypriot.com/post/your-number-one-source-for-docker-on-arm/) for adding apt repository to `apt-get install docker-compose`)
- [Trakt](https://trakt.tv/auth/join) account

### Installing

Clone down the repository with all submodules
```
git clone --recursive https://github.com/shivshav/rpi-media-server
```
```
cd rpi-media-server
```
Change variables in `env.sh` to suit your personal setup
```
vim env.sh
```
Start the containers
```
./create-containers.sh
```

### Setting up the integrations with Trakt
Get the trakt pin from flexget
```
docker logs flexget | grep -i "user code"
```

Navigate to https://trakt.tv/activate and input the pin from previous step to authorize FlexGet

Go to `http://<your-pi-IP>:8081/config/notifications/` and click `Authorize Trakt` to initiate setup procedure for SickRage

## Deployment
**TODO**
Add additional notes about how to deploy this on a live system

## Contributing
**TODO**
Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning
**TODO**
We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/shivshav/rpi-media-server/tags). 

## Authors
* **Shivneil Prasad**
See also the list of [contributors](https://github.com/shivshav/rpi-media-server/contributors) who participated in this project.

## License
**TODO**
This project is licensed under the **TODO** License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* SickRage, FlexGet community/maintainers for providing these awesome open-source projects

