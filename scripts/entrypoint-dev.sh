#!/bin/bash

# entrypoint-dev.sh

uvicorn src.app:app --port 8000 --host 0.0.0.0 --reload
