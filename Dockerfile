FROM python:3.13-slim-bookworm

RUN DEBIAN_FRONTEND=noninteractive
RUN set -ex && apt-get update && \
apt-get upgrade -y && \
rm -rf /var/lib/apt/lists/*

RUN chsh -s /usr/sbin/nologin root && addgroup --gid 1001 --system app && \
adduser --home /srv/app --shell /bin/false --disabled-password --uid 1001 --system --group app

RUN python -m pip install wheel setuptools pip --upgrade

USER app
ENV PATH=/srv/app/.local/bin/:$PATH
COPY . /srv/app/
RUN pip install --no-cache-dir pip-tools && pip-compile /srv/app/requirements.in && pip install --no-cache-dir -r /srv/app/requirements.txt

EXPOSE 8000
ENTRYPOINT [ "python3" ]
CMD ["/srv/app/main.py"]