FROM nvcr.io/nvidia/pytorch:20.03-py3

RUN apt-get update && apt-get install -y git python3-dev gcc \
    && rm -rf /var/lib/apt/lists/*

RUN cd / && git clone https://github.com/free-soellingeraj/fastai.git &&\
    cd fastai; tools/run-after-git-clone &&\
    pip install -e ".[dev]"

COPY requirements.txt .

RUN pip install --upgrade -r requirements.txt

COPY app app/

RUN python app/server.py

EXPOSE 5000

CMD ["python", "app/server.py", "serve"]
