FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install OpenJDK 17, SSH, MySQL
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk openssh-server mysql-server && \
    mkdir /var/run/sshd

# Set root password and enable root SSH login
RUN echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH and Spring Boot ports
EXPOSE 22 8080

# Copy and run Spring Boot app
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar
CMD service ssh start && java -jar /app.jar
