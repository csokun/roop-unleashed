FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu22.04

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON_VERSION=3.9.19
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl gnupg unixodbc-dev git \
  ca-certificates build-essential \
  zlib1g-dev libncurses5-dev libgdbm-dev libssl-dev libreadline-dev libffi-dev wget libbz2-dev libsqlite3-dev \
  ffmpeg libx264-dev && \
  update-ca-certificates && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir /python && cd /python && \
  wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz && \
  tar -zxvf Python-$PYTHON_VERSION.tgz && cd Python-$PYTHON_VERSION && \
  ./configure --enable-optimizations && \
  make install && rm -rf /python

WORKDIR /app

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .

EXPOSE 7860

CMD ["python3", "run.py"]
