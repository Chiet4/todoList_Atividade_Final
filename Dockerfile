FROM python:3.10-alpine

WORKDIR /app

COPY requirements.txt requirements.txt

RUN apk add --no-cache postgresql-dev gcc python3-dev musl-dev

RUN mkdir /app/todolist
RUN mkdir /app/todolist/templates

COPY wsgi.py wsgi.py

RUN pip install -r requirements.txt

COPY __init__.py todolist/__init__.py
COPY base.html todolist/templates/base.html

CMD [ "gunicorn", "--workers", "2",  "--bind", "0.0.0.0:8000", "wsgi:app" ]