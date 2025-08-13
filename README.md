# OTUS Model As a Service

Установка:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Ветка docker:
```bash
git checkout -t origin/docker
```

## План практики

* Установим docker на vm
* Напишем простой Dockerfile
* Запустим простой контейнер
* Подключимся внутрь контейнера
* Запустим jupyter notebook в контейнере и подключимся к нему
* Написать dev/prod Dockerfile и docker-compose для проекта c использованием FastAPI
* Развернуть/протестировать ML модель в контейнере с использованием FastAPI
