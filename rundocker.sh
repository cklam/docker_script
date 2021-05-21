sudo apt-get install qemu binfmt-support qemu-user-static # Install the qemu packages  

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts  

docker run --rm -t arm64v8/ubuntu uname -m # Testing the emulation environment  
aarch64 # Outputs the correct architecture

distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo apt install -y nvidia-docker2
sudo systemctl daemon-reload
sudo systemctl restart docker

docker pull nvcr.io/nvidia/l4t-base:r32.4.2
sudo docker run -it --rm --net=host --runtime nvidia  -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-5.0 -v /tmp/.X11-unix/:/tmp/.X11-unix nvcr.io/nvidia/deepstream-l4t:5.0-dp-20.04-samples
