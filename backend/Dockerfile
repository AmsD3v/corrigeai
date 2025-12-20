FROM python:3.10-slim-buster

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./src /app/src
COPY ./scripts /app/scripts

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]