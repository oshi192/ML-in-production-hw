import random
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "<a href='/app/predict'>prediction endpoint</a>"


@app.route('/app/predict')
def predict():
    return {"prediction": random.randint(0, 100)}


if __name__ == '__main__':
    app.run( debug=True, host="0.0.0.0", port=5000)
