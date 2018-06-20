FROM python:3.3-slim
LABEL maintainer="jeff@billimek.com"

ADD . /src
WORKDIR /src

RUN pip install -r requirements.txt

CMD ["python", "/src/SB6183.py"]