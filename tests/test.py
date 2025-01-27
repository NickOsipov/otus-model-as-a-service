import requests

def test_get():
    response = requests.get("http://localhost:8880/")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}

if __name__ == "__main__":
    test_get()
