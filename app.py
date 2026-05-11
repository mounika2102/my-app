from prometheus_client import Counter, generate_latest

REQUEST_COUNT = Counter(
    'app_requests_total',
    'Total App Requests'
)

@app.route("/")
def home():

    REQUEST_COUNT.inc()

    return "Hello OpenShift"

@app.route("/metrics")
def metrics():

    return generate_latest()
