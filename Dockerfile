FROM python:3.11.4-slim-buster

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

RUN chmod +x scripts/entrypoint-simple.sh

CMD ["bash", "scripts/entrypoint-simple.sh"]