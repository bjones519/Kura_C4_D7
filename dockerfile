FROM python:3.7

RUN git clone https://github.com/bjones519/Kura_C4_D6.git

WORKDIR Kura_C4_D6

RUN pip install pip --upgrade
RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN pip install mysqlclient
RUN python database.py
RUN python load_data.py

EXPOSE 8000

ENTRYPOINT [ "python", "-m", "gunicorn", "app:app", "-b", "0.0.0.0" ]
