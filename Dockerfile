
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN python -m pip install --no-cache-dir pytest pip-audit \
    && if [ -s requirements.txt ]; then \
         python -m pip install --no-cache-dir -r requirements.txt; \
       fi

COPY app.py test_app.py ./

RUN useradd --create-home appuser \
    && chown -R appuser:appuser /app

USER appuser

CMD ["python", "app.py"]
