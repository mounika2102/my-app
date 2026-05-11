from flask import Flask
from prometheus_client import Counter, generate_latest

app = Flask(__name__)

REQUEST_COUNT = Counter(
    'app_requests_total',
    'Total App Requests'
)

@app.route("/")
def home():

    REQUEST_COUNT.inc()

    return "Hello OpenShift"

@app.route("/health")
def health():

    return "OK", 200

@app.route("/metrics")
def metrics():

    return generate_latest()

if __name__ == "__main__":

    app.run(host="0.0.0.0", port=5000)
