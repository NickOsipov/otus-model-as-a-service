FROM python:3.12.8-slim-bookworm

ENV APP_HOME=/app
ENV PYTHONPATH=${APP_HOME}
WORKDIR ${APP_HOME}

# uv install
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Install dependencies
COPY pyproject.toml pyproject.toml
COPY uv.lock uv.lock
RUN uv sync
ENV PATH="${APP_HOME}/.venv/bin:$PATH"

# Copy source code and scripts
COPY src src
COPY config config
COPY scripts scripts
RUN chmod +x scripts/*.sh

CMD ["/app/scripts/entrypoint.sh"]
