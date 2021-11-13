FROM python:3-slim

WORKDIR /app

RUN apt-get update -qq && apt-get install -y make build-essential
COPY requirements.txt .
RUN pip3 install -r requirements.txt


COPY . .

CMD [ "python3", "main.py" ]
