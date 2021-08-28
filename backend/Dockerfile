FROM python:3.7.0

WORKDIR /usr/src/app

COPY ./requirements.txt .
COPY ./entrypoint.sh .

RUN pip install -r requirements.txt --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org
RUN chmod +x entrypoint.sh
RUN mkdir env

COPY . .

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
