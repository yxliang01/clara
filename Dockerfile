# Docker build script for clara

FROM fedora
MAINTAINER Ivan Radiček <radicek@forsyte.at>

# Update and install required software
RUN yum update -y
RUN yum install -y python-devel python-pip gcc make Cython lpsolve-devel git

# Install clara
WORKDIR /root/
COPY . /root/clara
WORKDIR /root/clara
RUN make install

# Add new user
RUN useradd -m clara

# Copy examples
RUN mkdir /home/clara/examples
COPY examples/* /home/clara/examples/
RUN chown -R clara:clara /home/clara/examples

# Change user & working directory
USER clara
WORKDIR /home/clara