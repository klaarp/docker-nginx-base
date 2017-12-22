import flask
from flask import render_template, flash, redirect, request, session, jsonify
from app import application

@application.route('/', methods=['GET', 'POST'])
@application.route('/index', methods=['GET', 'POST'])

def index():
    return render_template("index.html",
        title='Hello world'
        )
