FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED 1
ENV TZ Asia/Tokyo

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends vim curl zip unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists \
    && mkdir /workspace

WORKDIR /workspace
COPY requirements.txt /workspace/
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt
