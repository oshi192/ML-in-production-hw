# ML-in-production-hw
PR #1: Write a dummy docker file with a simple server and push it to your docker hub registry
### Docker:
 to build:
 ```
 sudo docker build -t oshi192/yurii-web-app:latest -f Dockerfile .
 ```
 to pull:
 ```
 docker pull oshi192/yurii-web-app:latest
 ```
 to run:
 ```
 docker run -p 80:5000 oshi192/yurii-web-app:latest
 ```
 link to check output : [localhost](http://127.0.0.1)
 

[link to yurii-web-app docker image](https://hub.docker.com/repository/docker/oshi192/yurii-web-app)