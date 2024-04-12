<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="frm" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>My Booking</title>

<script>
$(document).ready(function() {
    
	// Find all bookings by username and append to appropriate tables, upcoming, completed, canceled.
    var userName = "${username}";  // without quotations, it thinks evaluated ${username} is a variable and complains variable username is not found.
    $.get("findAllByUserName/" + userName, function(res) {  // call findAllByUserName of TravelGig (this project), get response.
        $("#tblBookingsCompleted tr:not(:first)").remove();  // remove all but first row which is table header
        console.log(res);
        
        $.each(res, function(idx, val) {
            var hotelName = "n/a";
            $.get("findHotelById/" + val.hotelId, function(hotel) {  // call findHotelById of TravelGig (this project), get response.
                $.get("findRoomTypeById/" + val.roomType, function(roomType) {  // call findRoomTypeById of TravelGig (this project), get response.
                    
                    if (val.status == "UPCOMING") {
                        $("#tblBookingsUpcoming").append("<tr>" + "<td>" + hotel.hotelName + "</td>" + "<td>" + val.noRooms + "</td>"
                            + "<td>" + val.checkInDate + "</td>" + "<td>" + val.checkOutDate + "</td>"
                            + "<td>" + roomType.name + "</td>"
                            + "<td>" + val.status + "</td>" + "<td>" + val.price + "</td>"
                            + "<td>" + "<button type='button' class='cancel-booking' attrBookingId='" + val.bookingId + "'>Cancel Booking</button>" + "</td>"
                        + "</tr>");
                    }
                	
                    if (val.status == "COMPLETED") {
                        $("#tblBookingsCompleted").append("<tr>" + "<td>" + hotel.hotelName + "</td>" + "<td>" + val.noRooms + "</td>"
                            + "<td>" + val.checkInDate + "</td>" + "<td>" + val.checkOutDate + "</td>"
                            + "<td>" + roomType.name + "</td>"
                            + "<td>" + val.status + "</td>" + "<td>" + val.price + "</td>"
                            + "<td>" + "<button type='button' class='write-review' attrBookingId='" + val.bookingId + "'>Write Review</button>" + "</td>"
                        + "</tr>");
                    }
                    
                    if (val.status == "CANCELED") {
                        $("#tblBookingsCanceled").append("<tr>" + "<td>" + hotel.hotelName + "</td>" + "<td>" + val.noRooms + "</td>"
                            + "<td>" + val.checkInDate + "</td>" + "<td>" + val.checkOutDate + "</td>"
                            + "<td>" + roomType.name + "</td>"
                            + "<td>" + val.status + "</td>" + "<td>" + val.price + "</td>"
                        + "</tr>");
                    }
                    
                });  // end ajax get findRoomTypeById
            });  // end ajax get findHotelById
        });  // end for each
    });  // end ajax get findAllByUserName
    
    
    // cancel-booking button on upcoming bookings table.
    // Can’t select dynamically generated element directly. So bind event using "on".
    // .on(name of event, name of class)
    // Of table, on click event of cancel-booking class
    $("#tblBookingsUpcoming").on("click", ".cancel-booking", function() {
    	var bookingId = $(this).attr("attrBookingId");
        $.ajax({
            type: "DELETE",  // It's delete call, but it actually updates by setting status to CANCELED.
            url: "http://localhost:8082/cancelBookingById/" + bookingId,  // call cancelBookingById of TravelGig (this project)
            success: function(res) {  // upon success of post request, run this function which takes response.
                // Every remove button's id & class is same. Need "this" to refer which one is selected.
                // (this = button or anchor tag that is clicked upon)
                // Remove parent (tr) of parent (td) of this (button/anchor)
            	// $(this).parent().parent().remove();
            	// $(this).closest("tr").remove();
            	location.reload();  // refreshes the page.
                alert("Booking canceled");
            },
            error: function(e) {
            	alert("Cannot cancel at this time. Please contact customer service.")
            }
        });  // end ajax delete
        
        // return false;  // prevent default behavior of anchor tag (redirecting)
    });  // end cancel-booking button click
    
    
    // Upon click of write-review button on completed bookings table, open modal.
    $("#tblBookingsCompleted").on("click", ".write-review", function() {
        $("#writeReviewsModal").toggle();
    	$("#review_bookingId").val($(this).attr("attrBookingId"));  // save currently selected bookingId
    });
    
    $("#writeReviewsModalClose").click(function() {
        $("#writeReviewsModal").hide();
    });
    
    $("#writeReviewsModalCloseOnX").click(function() {
        $("#writeReviewsModal").hide();
    });
    
    
    // Upon click of submit review button, save review.
    $("#id_submitReviewBtn").click(function() {    
        var reviewToPost = {
            "booking": {"bookingId": $("#review_bookingId").val()},
            "text": $("#id_reviewText").val(),
            "overallRating": parseInt($("#starValue").text())
        }
        
        $.ajax({
            type: "POST",
            contentType: "application/json",  // type of response I expect
            url: "http://localhost:8082/saveReview",
            data: JSON.stringify(reviewToPost),  // parse javascript object to json string
            dataType: "json",  // type of data I'm sending
            success: function(res) {  // upon success of post request, run this function which takes response.
                alert("Thank you for your review!");
                console.log($("#review_bookingId").val());
                console.log("Saved:");
                console.log(res);
            },
            error: function(e) {}
        });  // end ajax post
    });  // end submit review button click
    
});  // end doc ready
</script>

</head>
<body>
<div class="container" style="margin-left:100px">
<h1>My Bookings</h1>
<%
Object username = request.getAttribute("username");  // request.getAttribute("username") can be in java codes. ${username} can be in jsp codes.
if(username != null){
%>
<span>Welcome <%=username%>! &nbsp; <a href='login?logout'>Logout</a> &nbsp; <a href='home'>Home</a></span>
<%}else{%>
<a href='login'>Login</a>
<%}%>
</div>

<br/><br/>
<div class="row">

<div class="col-11 border rounded" style="margin-left:50px;">
    <div style='text-align:center;font-size:20px;font-family:"Trebuchet MS", Helvetica, sans-serif'>List of My Bookings</div>   
    
    <div id="listBookings">
        <div style='text-align:center;font-size:20px;font-family:"Trebuchet MS", Helvetica, sans-serif'>Upcoming</div>   
        <table class="table table-striped table-primary", id="tblBookingsUpcoming" border="1">
            <tr> <th>Hotel</th> <th>Number of Rooms</th> <th>Check In</th> <th>Check Out</th> <th>Room Type</th> <th>Booking Status</th> <th>Total Price</th> <th>Cancel</th> </tr>
        </table>
        
        <div style='text-align:center;font-size:20px;font-family:"Trebuchet MS", Helvetica, sans-serif'>Completed</div>   
        <table class="table table-striped table-primary", id="tblBookingsCompleted" border="1">
            <tr> <th>Hotel</th> <th>Number of Rooms</th> <th>Check In</th> <th>Check Out</th> <th>Room Type</th> <th>Booking Status</th> <th>Total Price</th> <th>Write Review</th> </tr>
        </table>
        
        <div style='text-align:center;font-size:20px;font-family:"Trebuchet MS", Helvetica, sans-serif'>Canceled</div>   
        <table class="table table-striped table-primary", id="tblBookingsCanceled" border="1">
            <tr> <th>Hotel</th> <th>Number of Rooms</th> <th>Check In</th> <th>Check Out</th> <th>Room Type</th> <th>Booking Status</th> <th>Total Price</th> </tr>
        </table>
    </div>
    
</div>
</div>

<!-- writeReviewsModal is to write a review of a hotel -->
<div class="modal" id=writeReviewsModal>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Write Your Review</h4>
        <button type="button" class="close" data-dismiss="modal" id="writeReviewsModalCloseOnX">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="writeReviews_modalBody">
            <div class="col">
                <div><input class="form-control" type="hidden" id="review_bookingId"/></div>
                
                <div class="container border rounded" style="margin:auto;padding:50px;margin-top:50px;margin-bottom:50px">
                    <div class="form">
                        <div class="slidecontainer">
                            Your Rating
                            <input type="range" min="1" max="10" value="10" class="slider" id="starRange">
                            <p>Stars: <span id="starValue"></span></p>
                        </div>
                        <div>
                            Your Review <textarea class="form-control" id="id_reviewText"></textarea>
                        </div>
                    </div>  <!-- end form -->
                    <br/>
                    <input class="btn-sm btn-primary" type="button" id="id_submitReviewBtn" value="Submit Review"/>
                </div>  <!-- end container border rounded -->
                
            </div>  <!-- end modal col -->
      </div>  <!-- end modal body -->
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="writeReviewsModalClose">Close</button>
      </div>
      
    </div>
  </div>
</div>
<!-- End writeReviewsModal -->

<script>
var slider = document.getElementById("starRange");
var output = document.getElementById("starValue");
output.innerHTML = slider.value;
slider.oninput = function() {
    output.innerHTML = this.value;
}
</script>
</body>
</html>
