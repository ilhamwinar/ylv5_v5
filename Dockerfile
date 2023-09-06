#FROM rapidsai/rapidsai-clx-nightly:21.08-cuda11.0-base-ubuntu18.04-py3.7
#FROM nvcr.io/nvidia/pytorch:21.03-py3


FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime
# Install linux packages
RUN apt update && apt install -y zip htop screen libgl1-mesa-glx
RUN apt-get -y install libglib2.0-0
# RUN apt-get -y install nvidia-340 

# Install python dependencies
COPY requirements.txt .
RUN pip uninstall -y nvidia-tensorboard nvidia-tensorboard-plugin-dlprof
RUN pip install --no-cache -r requirements.txt coremltools onnx gsutil notebook
RUN python -m pip install --upgrade pip
RUN python3 --version
RUN apt-get update && apt-get -y install openssh-client
RUN pip install paramiko



RUN ls

#VOLUME /home/iot/Model_Build/yolov5_docker/

WORKDIR ./yolov5_docker

#COPY . .



RUN ls 

#CMD ["ls"]

EXPOSE 8505

CMD ["./train.sh"]

#CMD ["uvicorn", "api:app","--host","0.0.0.0","--port","8505"]







# # Start FROM Nvidia PyTorch image https://ngc.nvidia.com/catalog/containers/nvidia:pytorch
# FROM nvcr.io/nvidia/pytorch:21.03-py3

# # Install linux packages
# RUN apt update && apt install -y zip htop screen libgl1-mesa-glx

# # Install python dependencies
# COPY requirements.txt .
# RUN python -m pip install --upgrade pip
# RUN pip uninstall -y nvidia-tensorboard nvidia-tensorboard-plugin-dlprof
# RUN pip install --no-cache -r requirements.txt coremltools onnx gsutil notebook

# # Create working directory
# RUN mkdir -p /usr/src/app
# WORKDIR /usr/src/app

# # Copy contents
# COPY . /usr/src/app

# # Set environment variables
# ENV HOME=/usr/src/app


# ---------------------------------------------------  Extras Below  ---------------------------------------------------

# Build and Push
# t=ultralytics/yolov5:latest && sudo docker build -t $t . && sudo docker push $t
# for v in {300..303}; do t=ultralytics/coco:v$v && sudo docker build -t $t . && sudo docker push $t; done

# Pull and Run
# t=ultralytics/yolov5:latest && sudo docker pull $t && sudo docker run -it --ipc=host --gpus all $t

# Pull and Run with local directory access
# t=ultralytics/yolov5:latest && sudo docker pull $t && sudo docker run -it --ipc=host --gpus all -v "$(pwd)"/coco:/usr/src/coco $t

# Kill all
# sudo docker kill $(sudo docker ps -q)

# Kill all image-based
# sudo docker kill $(sudo docker ps -qa --filter ancestor=ultralytics/yolov5:latest)

# Bash into running container
# sudo docker exec -it 5a9b5863d93d bash

# Bash into stopped container
# id=$(sudo docker ps -qa) && sudo docker start $id && sudo docker exec -it $id bash

# Send weights to GCP
# python -c "from utils.general import *; strip_optimizer('runs/train/exp0_*/weights/best.pt', 'tmp.pt')" && gsutil cp tmp.pt gs://*.pt

# Clean up
# docker system prune -a --volumes
