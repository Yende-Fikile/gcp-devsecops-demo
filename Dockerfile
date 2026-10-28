
FROM python:3.10-slim

ENV PYTHONDONTWRITEBENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

# Install tools and upgrade vulnerable Python packaging packages
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN python -m pip install --no-cache-dir --upgrade \
    pip setuptools filelock pytest pip-audit \
    && python -m pip check

COPY app.py test_app.py ./

RUN useradd --create-home appuser \
    && chown -R appuser:appuser /app

USER appuser

CMD ["python", "app.py"]
