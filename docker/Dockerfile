FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install awscli -y
COPY do_copy.sh do_copy.sh
RUN chmod +x do_copy.sh
CMD ./do_copy.sh