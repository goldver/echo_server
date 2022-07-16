from flask import Flask, request, render_template
import socket

app = Flask(__name__)

@app.route("/echo", methods=['POST','GET'])
def return_echo():
    data = request.get_data()
    ip = socket.gethostbyname(socket.gethostname())
    result = "echo string: " + str(data) + " ip: " + ip
    return result

@app.route("/index.html")
def index():
    return render_template('index.html')

if __name__ == "__main__":
    app.run(host="0.0.0.0")
