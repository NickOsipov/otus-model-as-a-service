# Dockerfile for jupyter
FROM python:3.12.8-slim-bookworm

WORKDIR /app

COPY requirements-dev.txt requirements-dev.txt

RUN pip install -r requirements-dev.txt

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
