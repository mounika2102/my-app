import os
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    app_name = os.getenv("APP_NAME", "Default App")
    return f"Hello from {app_name} 🚀"

@app.route("/health")
def health():
    return "FAIL", 500

if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
