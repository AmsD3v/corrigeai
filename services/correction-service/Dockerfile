FROM python:3.10-slim-bullseye

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* # Instala curl para healthcheck e depuração

# Instalar o modelo de linguagem do spaCy para português
# pt_core_news_sm é um modelo pequeno e eficiente para começar
RUN python -m spacy download pt_core_news_sm

COPY ./main.py /app/

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8002"]