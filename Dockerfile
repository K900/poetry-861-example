FROM fedora:30

# first, install python 2 and 3 side by side
RUN dnf -y install python2 python2-pip python3 python3-pip

# note that "pip" and "python" still point to python 2
RUN python --version
RUN pip --version

# and now let's install poetry to python 3
RUN pip3 install poetry
RUN poetry --version

# next, copy our app config
RUN mkdir -p /app
COPY pyproject.toml poetry.lock /app/
WORKDIR /app

# disable creating virtualenvs - we're in docker anyway
COPY config.toml /root/.config/pypoetry/config.toml

# and now let's install our app
RUN poetry install

# oh no!
