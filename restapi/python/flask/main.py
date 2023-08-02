from flask import Flask

app = Flask(__name__)

@app.route('/hello', methods=['GET'])
def say_hello():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(debug=True)
