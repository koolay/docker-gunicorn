FROM phusion/baseimage:0.9.19

# Set correct environment variables.
ENV HOME /root

#   Build system and git.
#RUN /bd_build/utilities.sh
#   Python support.

# ...put your own build instructions here...

RUN apt-get update \
    && /var/lib/dpkg/info/dash.preinst install && dpkg --configure -a
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential python3.5 \
    python3-dev libmysqlclient-dev mysql-client libssl-dev

RUN curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
    && python3 /tmp/get-pip.py

ENV PYTHONIOENCODING utf-8
# pip install
ADD ./requirements.txt /etc/requirements.txt
RUN pip3 install --upgrade pip \
	&& pip3 install -r /etc/requirements.txt

ADD ./bootstrap.sh /etc/my_init.d/
RUN mkdir /etc/service/app
ADD ./app.sh /etc/service/app/run
RUN chmod +x /etc/my_init.d/bootstrap.sh && chmod +x /etc/service/app/run
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove --purge --yes build-essential

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#WORKDIR /home/app/webapp
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
