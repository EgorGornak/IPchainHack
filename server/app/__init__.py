from flask import Flask, Config
from flask_login import LoginManager

app = Flask(__name__)
app.secret_key = 'my unobvious secret key'
login = LoginManager(app)
login.login_view = 'login'

from app import routes
