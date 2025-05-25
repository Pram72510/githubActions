#!/bin/bash
service ssh start
service mysql start
exec java -jar /app.jar
