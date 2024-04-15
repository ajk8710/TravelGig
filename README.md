# Hotel Reservation Application (TravelGig)
- Spring Boot application with microservices architecture.
- The user can look up hotels, filter searches by price and rating, log in to book available rooms, cancel bookings, see past/upcoming/canceled bookings, and rate/review hotels.
- Utilized Oracle for databases.

## Microservices
- [Booking Microservice](https://github.com/ajk8710/TravelGig-BookingMicroservice) - Handles APIs related to bookings.
- [Hotel Microservice](https://github.com/ajk8710/TravelGig-HotelMicroservice) - Handles APIs related to hotels.

## Deployment
- TravelGig App to be built (Maven) and deployed (Tomcat) by Jenkins.
- Deployed on AWS EC2 server.
- Triggering Jenkins by GitHub webhook and handling the firewall on EC2 by Smee.

## Tools
- Java 17, Spring, JavaScript, jQuery, HTML5, Bootstrap, Postman, Oracle DB, Maven, Tomcat, Jenkins
