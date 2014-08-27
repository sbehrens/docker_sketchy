docker_sketchy
=====================

Sketchy with Docker

To Install Sketchy on an EC2 instance

Launch an EC2 instance with Amazon Linux AMI
- sudo apt-get install -y docker.io
- sudo service docker start

Download sketchy repo from docker
- sudo docker pull nagwww/sketchy

Install Sketchy as
- sudo docker run -e "use_ssl=True" -e "host=ec2-xx-xxx-xxx-xxx.compute-1.amazonaws.com" -e  "C_FORCE_ROOT=true" -i -t -p 443:443 "nagwww/sketchy:v1" /home/ubuntu/sketchy.sh
- make sure to change the host to your public ec2 hostname

To build a Docker image
- Change the Dockerfile as needed

Build the image as
- docker build -t "nagwww/sketchy:v1" .

Push the image to Docker as
- docker push nagwww/sketchy
