FROM docker.io/python:3.10

WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

ENV GUNICORN_CMD_ARGS="--bind=0.0.0.0:8080 --chdir=./src/"

COPY . .

EXPOSE 8080

CMD ["gunicorn", "app:app"]