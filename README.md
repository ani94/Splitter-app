# Splitter-app
A SOA based web application that splits expenses in a group.
Consists of 3 microservices 
1. Splitter - This service contains Users, Groups of users, Transactions. 
2. Email - This service is responsible for sending emails using 3rd part API's. 
3. SMS - This service is responsible for sending SMS using 3rd part API's. 

## Steps to get the microservices up and running

1. Start RabbitMQ using this command /usr/local/opt/rabbitmq/sbin/rabbitmq-server. This starts on port 15672.
2. Start Splitter app service on local host port 3000. rails s -p 3000 is the command
3. Start the SMS service  on local host port 4000. rails s -p 4000 is the command.
4. Start the Email service  on local host port 5000. rails s -p 5000 is the command.
5. WORKERS=MailWorker rake sneakers:run to start the email service workers.
6. WORKERS=SmsWorker rake sneakers:run to start the email service workers.
