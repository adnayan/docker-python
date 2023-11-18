FROM python:slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1

RUN apt-get update && apt-get install -y sudo

ARG USER_ID
ARG GROUP_ID
ARG GROUP_NAME
ARG USER_NAME

RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} \
    && useradd -m -u ${USER_ID} -s /bin/bash -g ${GROUP_NAME} ${USER_NAME}

RUN echo '${USER_NAME} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/${USER_NAME}/app

USER ${USER_NAME}

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "./src/main.py"]