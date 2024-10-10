FROM python:3.11.4-slim-buster

WORKDIR /app

COPY scripts scripts
RUN chmod +x scripts/*.sh

# CMD ["bash", "scripts/entrypoint-simple.sh"]
CMD ["tail", "-f", "/dev/null"]