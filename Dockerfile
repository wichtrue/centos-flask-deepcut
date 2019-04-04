FROM centos:7.5.1804
MAINTAINER  Warawich Sureepitak <warawich@gmail.com>

# set flask environment
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV HOME=/root
ENV FLASK_APP=wsgi.py
ENV FLASK_DEBUG=1


# os update
RUN yum update -y && yum install -y \
     curl bzip2 wget

RUN  wget https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh -O ~/anaconda.sh

# COPY Anaconda3-5.3.1-Linux-x86_64.sh  /root/anaconda.sh

RUN bash ~/anaconda.sh -b -p ${HOME}/anaconda \
      && export PATH="$HOME/anaconda/bin:$PATH"

ENV PATH ${HOME}/anaconda/bin:$PATH

RUN conda install -y python=3.6.5 twisted PyHamcrest keras tensorflow matplotlib

RUN pip install deepcut

# NLU Application clone from https://github.com/Truevoice/nlu_development.git
# RUN git clone https://github.com/Truevoice/nlu_development.git
WORKDIR /app

COPY ./app /app

EXPOSE 9001


# CMD ["FLASK_APP=wsgi.py", "FLASK_DEBUG=1", "flask", "run", "--port=9001", "--host=0.0.0.0"]
CMD ["flask", "run", "--port=9001", "--host=0.0.0.0"]

