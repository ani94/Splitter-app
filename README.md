# Splitter-app
A SOA based web application that splits expenses in a group.
Consists of 3 microservices 
1. Splitter - This service contains Users, Groups of users, Transactions. 
2. Email - This service is responsible for sending emails using 3rd part API's. 
3. SMS - This service is responsible for sending SMS using 3rd part API's. 

## Steps to get the microservices up and running

1. Start RabbitMQ using this command /usr/local/opt/rabbitmq/sbin/rabbitmq-server. This starts on port 15672.
2. Start Splitter app service on local host port 3000. rails s -p 3000 is the command
3. Start the SMS service  on local host port 4000 if required. rails s -p 4000 is the command.
4. Start the Email service  on local host port 5000 if required . rails s -p 5000 is the command.
5. WORKERS=MailWorker rake sneakers:run to start the email service workers.
6. WORKERS=SmsWorker rake sneakers:run to start the email service workers.

## Architecture Diagram
![alt tag](http://s18.postimg.org/3m9w25crd/architecture_2.png)

## DataBase Schema for Splitter
![alt tag](http://s11.postimg.org/twtgfa47n/erd.png)

## Salient Features of Splitter Service
1. Reduces group based expenses to a graph that allowed the application of Tarjans’s strongly connected components algorithm that finds cycles in O(n) time complexity to quickly settle up expenses in a group.
2. Users can add transactions/bill expenses with friends in groups and normally.
3. Create your own groups.

## Salient Features of Email Service
1. Uses MailGun's 3rd party API for Sending emails of transactions. 
2. Consumes message sent on the email queue of RabbitMQ from splitter app.

## Salient Features of SMS Service
1. Uses Gupshups's 3rd party API for Sending sms of transactions. 
2. 2. Consumes message sent on the sms queue of RabbitMQ from splitter app.
