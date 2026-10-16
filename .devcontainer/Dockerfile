FROM python:3.13

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED 1
ENV TZ Asia/Tokyo

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends vim curl zip unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists \
    && mkdir /workspace \
    && mkdir /install

COPY --from=ghcr.io/astral-sh/uv:0.12.3 /uv /usr/local/bin/uv

ENV UV_PROJECT_ENVIRONMENT=/opt/venv
ENV UV_LINK_MODE=copy
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /install
COPY pyproject.toml uv.lock /install/
RUN uv sync --frozen --no-install-project
