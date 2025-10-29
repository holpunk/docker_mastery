import flask
from flask import Flask, jsonify, request

app = Flask(__name__)
@app.route('/')
def home():
    return "Welcome to the Flask API!"
@app.route('/api/data', methods=['GET'])
def get_data():
    sample_data = {
        "name": "Flask API",
        "version": "1.0",
        "description": "This is a sample Flask API"
    }
    return jsonify(sample_data)
@app.route('/api/echo', methods=['POST'])
def echo_data():
    data = request.json
    return jsonify(data)
if __name__ == '__main__':
    app.run(debug=True)
@app.route('/api/status', methods=['GET'])
def get_status():
    status_info = {
        "status": "running",
        "uptime": "48 hours",
        "version": "1.0"
    }
    return jsonify(status_info)
@app.route('/api/greet/<name>', methods=['GET'])
def greet_user(name):
    greeting = {
        "message": f"Hello, {name}! Welcome to the Flask API."
    }
    return jsonify(greeting)
@app.route('/api/sum', methods=['POST'])
def sum_numbers():
    data = request.json
    numbers = data.get("numbers", [])
    total = sum(numbers)
    return jsonify({"sum": total})
@app.route('/api/reverse', methods=['POST'])
def reverse_string():
    data = request.json
    original_string = data.get("string", "")
    reversed_string = original_string[::-1]
    return jsonify({"reversed": reversed_string})
@app.route('/api/items', methods=['GET'])
def get_items():
    items = [
        {"id": 1, "name": "Item One"},
        {"id": 2, "name": "Item Two"},
        {"id": 3, "name": "Item Three"}
    ]
    return jsonify(items)
@app.route('/api/item/<int:item_id>', methods=['GET'])
def get_item(item_id):
    item = {"id": item_id, "name": f"Item {item_id}"}
    return jsonify(item)
