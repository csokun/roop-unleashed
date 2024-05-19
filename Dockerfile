FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
  apt-get install -y ffmpeg curl libgl1 libglib2.0-0 python3-pip python-is-python3 git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 7860

CMD ["python", "run.py"]
