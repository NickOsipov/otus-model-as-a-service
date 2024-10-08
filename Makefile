start_server:
	uvicorn src.app:app --reload --port 8890

test:
	echo "Running tests"