from flask import Flask
app = Flask(**name**)

@app.route('/')
def hello():
return "Hello from Docker CI/CD!"

if **name** == '**main**':
app.run(host='0.0.0.0', port=5000)
