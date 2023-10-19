FROM python:3.8-slim
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir redis flask
EXPOSE 80
CMD ["python", "app.py"]
