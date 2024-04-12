<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Home Page of Travel Gig</title>

<script>
$(document).ready(function() {
	
    $("#searchBtn").click(function() {  // upon click of searchBtn
        var searchString = $("#searchLocation").val();
        $.get("searchHotel/" + searchString, function(res) {  // call searchHotel of TravelGig (this project), get response.
            $("#tblHotel tr:not(:first)").remove();  // remove all but first row which is table header
            $.each(res, function(idx, val) {
                $("#tblHotel").append("<tr>" + "<td>" + val.hotelName + "</td>" + "<td>" + val.address + "</td>"
                    + "<td>" + val.city + "</td>" + "<td>" + val.state + "</td>"
                    + "<td>" + val.averagePrice + "</td>"
                    // + "<td>" + "<a href='#' class='hotelDetailOnImage'><img length=300 width=200 src='" + val.imageURL + "'></img></a>" + "</td>"
                    + "<td>" + "<img length=300 width=200 src='" + val.imageURL + "' class='hotelDetailOnImage' attrHotelId='" + val.hotelId + "'></img>" + "</td>"
                    + "<td>" + "<a href='#' class='hotelReviewsLink' attrHotelId='" + val.hotelId + "'>" +  val.starRating + "</a>" + "</td>"
                    // + "<td>" + "<button type='button' class='open-my-Modal btn btn-primary' data-toggle='modal' data-target='#searchHotelRoomsModal' attrHotelId='" + val.hotelId + "'>Hotel Detail</button>" + "</td>"
                    + "</tr>");
            });
        });
    });
    
    $("#filterBtn").click(function() {
        //$("#tblHotel tr").not(":first").show();  // Show everything again except first row (header) (Resets filtered table back to unfiltered.)
        $("#tblHotel tr").not(":first").hide();  // Logic the other way compared to above. Hide everything, then show per filter.
        
        var selectedPrice = parseInt($("#priceValue").text());  // max price to filter
        var filterStar1 = $("#1_star_rating").is(":checked");  // see if checkbox is checked
        var filterStar2 = $("#2_star_rating").is(":checked");
        var filterStar3 = $("#3_star_rating").is(":checked");
        var filterStar4 = $("#4_star_rating").is(":checked");
        var filterStar5 = $("#5_star_rating").is(":checked");
        
        $("#tblHotel tr").not(":first").each(function(idx, val) {  // for each row except first row (header), iterate.
            var price = $(this).children("td").eq("4").text();  // this rows's children, 4th colum is price, get its text.
            var star = $(this).children("td").eq("6").text();  // get its star rating
            
            // if (price > selectedPrice) {
            // 	   $(this).hide()  // hide() not remove() because it needs to show back when re-filtering
            // }
            if (price <= selectedPrice) {  // if within price
                if (!(filterStar1 || filterStar2 || filterStar3 || filterStar4 || filterStar5)) {  // if no star is filtered
                    $(this).show()  // then show
                }
                else if (star == 1 && filterStar1) {  // else see if this star filter is checked
                    $(this).show()  // then show
                }
                else if (star == 2 && filterStar2) {
                    $(this).show()
                }
                else if (star == 3 && filterStar3) {
                    $(this).show()
                }
                else if (star == 4 && filterStar4) {
                    $(this).show()
                }
                else if (star == 5 && filterStar5) {
                    $(this).show()
                }
            }
        });  // end iteration of rows
    });  // end filterBtn
    
    /*
    // Opens modal upon clicking button. Not using it now. Instead click image.
    $("#tblHotel").on("click", ".open-my-Modal", function() {
        var hotelName = $(this).parent().parent().children("td").eq(0).text();  // parent (column), parent (row), children of 0th.
        $("#modal_hotelName").val(hotelName);  // Sets textfields in modal
        $("#modal_noRooms").val($("#noRooms").val());
        $("#modal_noGuests").val($("#noGuests").val());
        $("#modal_checkInDate").val($("#checkInDate").val());
        $("#modal_checkOutDate").val($("#checkOutDate").val());
        
        $("#select_roomTypes").empty()  // empty selection options, otherwise options keeps appended as button clicking.
        var hotelId = $(this).attr("attrHotelId");  // grab hotelId to call getRoomTypesOfHotel/hotelId
        $.get("getRoomTypesOfHotel/" + hotelId, function(res) {  // call getRoomTypesOfHotel of TravelGig (this project), get response.
            $.each(res, function(idx, item) {  // for each roomtype
                $('#select_roomTypes').append($("<option>", {  // append as selection option
                    value: item.typeId,
                    text: item.name
                }));
            });
        });
    });
    */
    
    // Opens modal upon clicking image.
    $("#tblHotel").on("click", ".hotelDetailOnImage", function() {
        $("#searchHotelRoomsModal").toggle();
        
        var hotelName = $(this).parent().parent().children("td").eq(0).text();  // parent (column), parent (row), children of 0th.
        $("#modal_hotelName").val(hotelName);  // Sets textfields in modal
        $("#modal_noRooms").val($("#noRooms").val());
        $("#modal_noGuests").val($("#noGuests").val());
        $("#modal_checkInDate").val($("#checkInDate").val());
        $("#modal_checkOutDate").val($("#checkOutDate").val());
        
        $('#select_roomTypes').empty()  // empty selection options, otherwise options keeps appended as button clicking.
        var hotelId = $(this).attr("attrHotelId");  // grab hotelId to call getRoomTypesOfHotel/hotelId
        $.get("getRoomTypesOfHotel/" + hotelId, function(res) {  // call getRoomTypesOfHotel of TravelGig (this project), get response.
            $.each(res, function(idx, item) {  // for each roomtype
                $("#select_roomTypes").append($("<option>", {  // append as selection option
                    value: item.typeId,
                    text: item.name
                }));
            });
        });
        
        $("#modal_hotelId").val(hotelId);  // hidden textfield with id=modal_hotelId. Save hotelId as value. So outside of this modal knows which hotel was clicked.
        
        return false;
    });
    
    // Modal opened by anchor tag or image tag does not close without this (unlike modal opened by button).
    $("#searchHotelRoomsModalClose").click(function() {
        $("#searchHotelRoomsModal").hide();
    });
    
    // Modal opened by anchor tag or image tag does not close without this (unlike modal opened by button).
    $("#searchHotelRoomsModalCloseOnX").click(function() {
        $("#searchHotelRoomsModal").hide();
    });
    
    
    var currentlySelectedRoomTypeId = 0;  // need this on completeBookingGuestInfoModal, declare here outside of any buttons.
    var currentlySelectedRoomId = 0;  // need this on completeBookingGuestInfoModal, declare here outside of any buttons.
    
    // Upon click of searchHotelRoomsBtn, hide searchHotelRoomsModal (preview for booking) and open bookingHotelRoomModal
    $("#searchHotelRoomsBtn").click(function() {
        $("#searchHotelRoomsModal").hide();
        $("#bookingHotelRoomModal").toggle();
        
        $("#booking_hotelName").val($("#modal_hotelName").val());  // copy details from searchHotelRoomsModal
        $("#booking_noRooms").val($("#modal_noRooms").val());
        $("#booking_noGuests").val($("#modal_noGuests").val());
        $("#booking_checkInDate").val($("#modal_checkInDate").val());
        $("#booking_checkOutDate").val($("#modal_checkOutDate").val());
        var selectedRoomType_Text = $('#select_roomTypes').find(":selected").text();  // get selected room type
        var roomTypeId = $('#select_roomTypes').find(":selected").val();
        $("#booking_roomType").val(selectedRoomType_Text);
        // booking_customerMobile - may be feteched from user info
        
        currentlySelectedRoomTypeId = roomTypeId;  // need this on completeBookingGuestInfoModal, set it here.
        
        var hotelId = $("#modal_hotelId").val();
        $.get("getRoomPriceAndDiscount/" + hotelId + "/" + roomTypeId, function(resRoomPriceAndDiscount) {  // call getRoomPriceAndDiscount of TravelGig (this project), get response.
            $.each(resRoomPriceAndDiscount, function(idx, item) {  // for each item. idx 0 is price. idx 1 is discount. idx 2 is room id. Room id represents rooms of same type and price. A room entity contains number of rooms.
                var noRooms = 1;
                if (idx == 0) {  // idx 0 is price
                    if ($("#booking_noRooms").val()) {  // if noRooms to book has value (user input), set to it. Else leave as 1 room.
                        noRooms = $("#booking_noRooms").val();
                    }
                    else {
                    	$("#booking_noRooms").val(1);
                    }
                    $("#booking_noRoomsOnSummary").text(noRooms);
                    $("#booking_pricePerRoom").text(item);  // idx 0 is price
                    
                    var start = $("#modal_checkInDate").val();
                    var end = $("#modal_checkOutDate").val();
                    var diffInDays = new Date(Date.parse(end) - Date.parse(start)) / 86400000;
                    if (isNaN(diffInDays)) {
                    	$("#booking_noNights").text("Please choose check in/out dates.");
                    	$("#booking_price_beforeDiscount").text("Please choose check in/out dates.");
                    }
                    else {
                    	$("#booking_noNights").text(diffInDays);
                    	$("#booking_price_beforeDiscount").text(item * noRooms * diffInDays);  // setting text value of span tag
                    }
                }
                else if (idx == 1) {  // idx 1 is discount
                	$("#booking_discountPercentage").text(item);  // idx 1 is discount
                	
                    var start = $("#modal_checkInDate").val();
                    var end = $("#modal_checkOutDate").val();
                	var diffInDays = new Date(Date.parse(end) - Date.parse(start)) / 86400000;
                	if (isNaN(diffInDays)) {
                		$("#booking_discount").text("Please choose check in/out dates.");
                		$("#booking_price_total").text("Please choose check in/out dates.");
                	}
                	else {
                        $("#booking_discount").text($("#booking_price_beforeDiscount").text() * item * 0.01);  // setting text value of span tag
                        $("#booking_price_total").text($("#booking_price_beforeDiscount").text() - $("#booking_discount").text());  // apply discount on total price.
                	}
                }
                else {  // idx 2 is room id
                    currentlySelectedRoomId = Math.floor(item);  // Casting float to int. Need this room id on completeBookingGuestInfoModal.
                }
            });  // end for-each loop
        });  // end ajax get getRoomPriceAndDiscount
    });  // end click of searchHotelRoomsBtn
    
    $("#bookingHotelRoomModalClose").click(function() {
        $("#bookingHotelRoomModal").hide();
    });
    
    $("#bookingHotelRoomModalCloseOnX").click(function() {
        $("#bookingHotelRoomModal").hide();
    });
    
    
    // Edit button on bookingHotelRoomModal: hide bookingHotelRoomModal and re-open bookingHotelRoom modal.
    $("#editConfirmBookingBtn").click(function() {
        $("#bookingHotelRoomModal").hide();
        $("#searchHotelRoomsModal").toggle();
    });  // end click of confirmBookingBtn
    
    
    // Upon click of confirmBookingBtn, hide bookingHotelRoomModal (comfirm for booking) and open completeBookingGuestInfoModal
    $("#confirmBookingBtn").click(function() {
        var start = $("#modal_checkInDate").val();
        var end = $("#modal_checkOutDate").val();
        var diffInDays = new Date(Date.parse(end) - Date.parse(start)) / 86400000;
        
        var userName = "${username}";  // without quotations, it thinks evaluated ${username} is a variable and complains variable username is not found.
        console.log("userName: " + userName);
        if (!userName) {  // userName == "" also would work
            alert("Please log in to book.");
        }
        else if (isNaN(diffInDays)) {
            alert("Please choose check in/out dates.");
        }
        else if (diffInDays < 1) {
        	alert("Please choose valid check in/out dates (in before out).");
        }
        else if ($("#booking_noRooms").val() < 1) {
            alert("Please choose valid number of rooms >= 1");
        }
        else {
            $("#bookingHotelRoomModal").hide();
            $("#completeBookingGuestInfoModal").toggle();
            //alert($("#booking_noGuests").val());
            
            $("#id_guestFirstName").val("");  // discard previous values
            $("#id_guestLastName").val("");
            $("#id_guestAge").val("");
            $("#id_guestGender").val("");
        }
    });  // end click of confirmBookingBtn
    
    
    // On completeBookingGuestInfoModal: Upon click of id_addGuestBtn, add a guest to guest list, also append to tblGuest.
    var guestList = [];
    $("#id_addGuestBtn").click(function() {
        var guestFirstName = $("#id_guestFirstName").val();
        var guestLastName = $("#id_guestLastName").val();
        var guestAge = parseInt($("#id_guestAge").val());
        var guestGender = $("#id_guestGender").val();
        
        var guestToAdd = {"firstName": guestFirstName, "lastName": guestLastName, "gender": guestGender, "age": guestAge};
        guestList.push(guestToAdd);
        
        $("#tblGuest").append("<tr>" + "<td>" + guestFirstName + "</td>" + "<td>" + guestLastName + "</td>"
    	                             + "<td>" + guestAge + "</td>" + "<td>" + guestGender + "</td>"
                                     // + "<td> <a href='' class='removeGuestFromTable'>Remove</a> </td>" + "</tr>");
                                     + "<td>" + "<button type='button' class='removeGuestFromTable btn btn-primary'>Remove</button>" + "</td>" + "</tr>");
        
        // console.log("guestToAdd:");  // string concatenation makes it [object Object]
        // console.log(guestToAdd);
        // console.log("guestList:");
        // console.log(guestList);
    });
    
    
    // Remove guest button on guest table.
    // Can’t select dynamically generated element directly. So bind event using "on".
    // .on(name of event, name of class)
    // Of table, on click event of removeFromTable class
    $("#tblGuest").on("click", ".removeGuestFromTable", function() {
        // Every remove button's id & class is same. Need "this" to refer which one is selected.
        // (this = button or anchor tag that is clicked upon)
        // Remove parent (tr) of parent (td) of this (button/anchor)
        $(this).parent().parent().remove();
        
        // var indexOnGuestList = $(this).parent().siblings().eq(4).text());  // 0 1 2 3 this-button 4
        var firstNameOfRemoved = $(this).parent().siblings().eq(0).text();
        var lastNameOfRemoved =  $(this).parent().siblings().eq(1).text();
        var ageOfRemoved =       $(this).parent().siblings().eq(2).text();
        var genderOfRemoved =    $(this).parent().siblings().eq(3).text();
        
        var idxOfRemoved = -1;
        for (i = 0; i < guestList.length; i++) {
            if (guestList[i].firstName == firstNameOfRemoved && guestList[i].lastName == lastNameOfRemoved &&
                guestList[i].age == ageOfRemoved && guestList[i].gender == genderOfRemoved) {
                idxOfRemoved = i;
                break;
            }
        }
        guestList.splice(idxOfRemoved, 1); // splice(start, deleteCount) is javascript's remove from array.
        
        // console.log("guestList:");
        // console.log(guestList);
    	
        // How to get value of another column:
        // this.td.tr.tr's children which are tds.0th column.its text
        // $(this).parent().parent().children().eq(0).text();
        
        // this.td.td's siblings which are tds.0th column.its text
        // $(this).parent().siblings().eq(0).text();
        
        return false;  // prevent default behavior of anchor tag (redirecting)
    });
    
    
    // On completeBookingGuestInfoModal: Upon click of completeBookingGuestInfoBtn, do post call to saveBooking
    $("#completeBookingGuestInfoBtn").click(function() {
    	/*  Posting guest. Can't post a booking with desired guest IDs, if I post guests first.
    	for (var gst of guestList) {  // For each guest in guestList, do post call.
            // Post request to url localhost:8082/saveGuest of this project's GuestController.
            // It calls GuestClient, then it calls GuestController of BookingMicroservice, which calls Service layer, do DAO work with repository, then returns.
            $.ajax({
                type: "POST",
                contentType: "application/json",  // type of response I expect
                url: "http://localhost:8082/saveGuest",
                data: JSON.stringify(gst),  // parse javascript object to json string
                dataType: "json",  // type of data I'm sending
                success: function(res) {  // upon success of post request, run this function which takes response. Response is saved Guest object.
                    console.log("Saved:");
                    console.log(res);
                },
                error: function(e) {}
            });  // end ajax post
    	}
    	*/
    	
    	// Posting booking.
    	var bookingToPost = {
    	    "hotelId": $("#modal_hotelId").val(),
    	    "hotelRoomId": currentlySelectedRoomId,
    	    "noRooms": $("#booking_noRooms").val(),
    	    "guests": guestList,
    	    "checkInDate": $("#booking_checkInDate").val(),
    	    "checkOutDate": $("#booking_checkOutDate").val(),
    	    "status": "UPCOMING",
    	    "price": $("#booking_price_total").text(),
    	    "discount": $("#booking_discount").text(),
    	    "customerMobile": $("#booking_customerMobile").val(),
    	    "roomType": currentlySelectedRoomTypeId,
    	    "userName": "${username}",  // without quotations, it thinks evaluated ${username} is a variable and complains variable username is not found.
    	    "userEmail": "${userEmail}"
    	}
    	
        // Post request to url localhost:8082/saveBooking of this project's BookingController.
        // It calls BookingClient, then it calls BookingController of BookingMicroservice, which calls Service layer, do DAO work with repository, then returns.
        $.ajax({
            type: "POST",
            contentType: "application/json",  // type of response I expect
            url: "http://localhost:8082/saveBooking",
            data: JSON.stringify(bookingToPost),  // parse javascript object to json string
            dataType: "json",  // type of data I'm sending
            success: function(res) {  // upon success of post request, run this function which takes response. Response is saved Guest object.
            	alert("Thank you for booking!");
            	// console.log("Saved:");
                // console.log(res);
            },
            error: function(e) {}
        });  // end ajax post
    	
    	guestList = [];  // empty guestList, so it won't keep adding duplicate guests on next booking.
    	$("#tblGuest tr:not(:first)").remove();  // remove all but first row which is table header
        $("#id_guestFirstName").val();  // reset input fields for the guest
        $("#id_guestLastName").val();
        $("#id_guestAge").val();
        $("#id_guestGender").val();
    });
    
    $("#completeBookingGuestInfoModalClose").click(function() {
        $("#completeBookingGuestInfoModal").hide();
        guestList = [];  // empty guestList, so it won't keep adding duplicate guests on next booking.
        $("#tblGuest tr:not(:first)").remove();  // remove all but first row which is table header
    });
    
    $("#completeBookingGuestInfoModalCloseOnX").click(function() {
        $("#completeBookingGuestInfoModal").hide();
        guestList = [];  // empty guestList, so it won't keep adding duplicate guests on next booking.
        $("#tblGuest tr:not(:first)").remove();  // remove all but first row which is table header
    });
    
    
    // Opens modal upon clicking hotel rating.
    $("#tblHotel").on("click", ".hotelReviewsLink", function() {
        $("#hotelReviewsModal").toggle();
        var sumOfUserRating = 0;
        var numReviews = 0;
        
        var hotelId = $(this).attr("attrHotelId");
        $.get("findAllReviewsByHotelId/" + hotelId, function(res) {  // call findAllReviewsByHotelId of TravelGig (this project), get response.
        	$("#tblReviews tr:not(:first)").remove();  // remove all but first row which is table header
            $.each(res, function(idx, val) {
                $("#tblReviews").append("<tr>" + "<td>" + val.booking.userName + "</td>" + "<td>" + val.overallRating + "</td>"
                    + "<td>" + val.text + "</td>"
                    + "</tr>");
                sumOfUserRating += val.overallRating;
                numReviews++;
            });
        	
            var avgUserRating = sumOfUserRating / numReviews;
            $("#id_avgUserRating").text("User Rating: " + avgUserRating);
        });
        
        // This runs before get call finishes and return.
        // var avgUserRating = sumOfUserRating / numReviews;
        
        return false;
    });
    
    $("#hotelReviewsModalClose").click(function() {
        $("#hotelReviewsModal").hide();
        $("#tblReviews tr:not(:first)").remove();  // remove all but first row which is table header
    });
    
    $("#hotelReviewsModalCloseOnX").click(function() {
        $("#hotelReviewsModal").hide();
        $("#tblReviews tr:not(:first)").remove();  // remove all but first row which is table header
    });
    
    
});  // end dom ready
</script>
</head>

<body>
<div class="container" style="margin-left:100px">
<h1>Welcome to Travel Gig</h1>
<h2>Search your desired hotel</h2>
<%
Object username = request.getAttribute("username");  // request.getAttribute("username") can be in java codes. ${username} can be in jsp codes.
if(username != null){
%>
<span>Welcome <%=username%>! &nbsp; <a href='login?logout'>Logout</a> &nbsp; <a href='mybookings'>My Bookings</a></span>
<%}else{%>
<a href='login'>Login</a> &nbsp; <a href='register'>Sign Up</a>
<%}%>
</div>

<div class="container border rounded" style="margin:auto;padding:50px;margin-top:50px;margin-bottom:50px">
    <h3>Narrow your search results</h3>
    <div class="form-row">
    <div class="col-3">
        Hotel/City/State/Address <input class="form-control" type="text" id="searchLocation" name="searchLocation"/>
    </div>
    <div class="col-2">
        No. Rooms: <input class="form-control" type="number" id="noRooms" name="noRooms"/>
    </div>
    <div class="col-2">
        No. Guests: <input class="form-control" type="number" id="noGuests" name="noGuests"/>
    </div>
    <div class="col">
    Check-In Date: <input type="date" id="checkInDate" name="checkInDate"/>
    </div>
    <div class="col">
    Check-Out Date: <input type="date" id="checkOutDate" name="checkOutDate"/>
    </div>
    <input class="btn-sm btn-primary" type="button" id="searchBtn" value="SEARCH"/>
    </div>  <!-- end form-row -->
</div>  <!-- end container border rounded -->

<div class="row">
<div class="col-2 border rounded" style="margin-left:50px;padding:25px">
    
    <br>
    <!--  Star Rating: 
    <select class="form-control" id="filter_starRating">
        <option value=0>Select</option>
        <option value=1>1</option>
        <option value=2>2</option>
        <option value=3>3</option>
        <option value=4>4</option>
        <option value=5>5</option>
    </select><br>--> 
    
    Star Rating:<br>
    <div class="form-check-inline">
        <label class="form-check-label">
            <input type="checkbox" class="star_rating form-check-input" id="1_star_rating" value=1>1
        </label>
    </div>
    <div class="form-check-inline">
        <label class="form-check-label">
            <input type="checkbox" class="star_rating form-check-input" id="2_star_rating" value=2>2
        </label>
    </div>
    <div class="form-check-inline">
        <label class="form-check-label">
            <input type="checkbox" class="star_rating form-check-input" id="3_star_rating" value=3>3
        </label>
    </div>
    <div class="form-check-inline">
        <label class="form-check-label">
            <input type="checkbox" class="star_rating form-check-input" id="4_star_rating" value=4>4
        </label>
    </div>
    <div class="form-check-inline">
        <label class="form-check-label">
            <input type="checkbox" class="star_rating form-check-input" id="5_star_rating" value=5>5
        </label>
    </div><br><br>
    
    Range:
    <div class="slidecontainer">
        <input type="range" min="1" max="500" value="500" class="slider" id="priceRange">
        <p>Price: $<span id="priceValue"></span></p>
    </div>
    
    <div class="form-check">
        <input type="checkbox" class="hotel_amenity form-check-input" id="amenity_parking" value="PARKING"/>
        <label class="form-check-label" for="amenity_parking">Parking</label><br>
        
        <input type="checkbox" class="hotel_amenity form-check-input" id="amenity_checkin_checkout" value="CHECK-IN & CHECK-OUT TIMES"/>
        <label class="form-check-label" for="amenity_checkin_checkout">Check-In & Check-Out Times</label><br>
        
        <input type="checkbox" class="hotel_amenity form-check-input" id="amenity_breakfast" value="BREAKFAST"/>
        <label class="form-check-label" for="amenity_breakfast">Breakfast</label><br>
        
        <input type="checkbox" class="hotel_amenity form-check-input" id="amenity_bar_lounge" value="BAR OR LOUNGE"/>
        <label class="form-check-label" for="amenity_bar_lounge">Bar / Lounge</label><br>
        
        <input type="checkbox" class="hotel_amenity form-check-input" id="amenity_fitness_center" value="FITNESS CENTER"/>
        <label class="form-check-label" for="amenity_fitness_center">Fitness Center</label><br>
    </div>
    
    <input style="margin-top:25px" class="btn btn-primary" type="button" id="filterBtn" value="FILTER"/>    
</div>  <!-- end col-2 border rounded -->


<div class="col-7 border rounded" style="margin-left:50px;">
    <div style='text-align:center;font-size:20px;font-family:"Trebuchet MS", Helvetica, sans-serif'>List of Hotels:</div>   
    
    <div id="listHotel">
        <table id="tblHotel" border="1">
            <!-- <tr> <th>Name</th> <th>Address</th> <th>City</th> <th>State</th> <th>Price</th> <th>Image</th> <th>Rating</th> <th>Detail</th> </tr> -->
            <tr> <th>Name</th> <th>Address</th> <th>City</th> <th>State</th> <th>Price</th> <th>Image</th> <th>Rating</th> </tr>
        </table>
    </div>

</div>
</div>

<!-- searchHotelRoomsModal is to preview before booking hotel room -->
<div class="modal" id="searchHotelRoomsModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Search Rooms</h4>
        <button type="button" class="close" data-dismiss="modal" id="searchHotelRoomsModalCloseOnX">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">        
        <div class="col">
            <input class="form-control" type="hidden" id="modal_hotelId"/>
            Hotel Name: <input readonly="true" class="form-control" type="text" id="modal_hotelName"/>
            No. Guests: <input class="form-control" type="number" id="modal_noGuests"/>
            Check-In Date: <input class="form-control" type="date" id="modal_checkInDate"/>
            Check-Out Date: <input class="form-control" type="date" id="modal_checkOutDate"/>
            Room Type: 
            <select class="form-control" id="select_roomTypes">
            </select>
            No. Rooms: <input class="form-control" type="number" id="modal_noRooms"/>
            <input style="margin-top:25px" class="btn btn-searchHotelRooms form-control btn-primary" type="button" id="searchHotelRoomsBtn" value="SEARCH"/>           
        </div>
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="searchHotelRoomsModalClose">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- End searchHotelRoomsModal -->

<!-- hotelRoomsModal is temporary setup. Not using for now. -->
<div class="modal" id="hotelRoomsModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Are these details correct?</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="hotelRooms_modalBody">        
              
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- End hotelRoomsModal. Not using for now. -->

<!-- bookingHotelRoomModal is to book hotel room -->
<div class="modal" id="bookingHotelRoomModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"></h4>
        <button type="button" class="close" data-dismiss="modal" id="bookingHotelRoomModalCloseOnX">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="bookingRoom_modalBody">
            <div class="col">
                <div><input class="form-control" type="hidden" id="booking_hotelId"/></div>
                <div><input class="form-control" type="hidden" id="booking_hotelRoomId"/></div>
                <div>Hotel Name: <input readonly="true" class="form-control" type="text" id="booking_hotelName"/></div>
                <div>Customer Mobile: <input class="form-control" type="text" id="booking_customerMobile"/></div>
                <div id="noGuestsDiv">No. Guests: <input class="form-control" type="number" id="booking_noGuests"/></div>
                <div>No. Rooms: <input readonly="true" class="form-control" type="number" id="booking_noRooms"/></div>
                <div>Check-In Date: <input readonly="true" class="form-control" type="text" id="booking_checkInDate"/></div>
                <div>Check-Out Date: <input readonly="true" class="form-control" type="text" id="booking_checkOutDate"/></div>
                <div>Room Type: <input readonly="true" class="form-control" type="text" id="booking_roomType"/></div>
                <div>Price per Room: $<span id="booking_pricePerRoom"></span></div>
                <div>Number of Rooms: <span id="booking_noRoomsOnSummary"></span></div>
                <div>Number of Nights: <span id="booking_noNights"></span></div>
                <div>Price Before Discount: $<span id="booking_price_beforeDiscount"></span></div>
                <div>Discount Percentage: <span id="booking_discountPercentage"></span>%</div>
                <div>Discount Amount: $<span id="booking_discount"></span></div>
                <div>Total Price: $<span id="booking_price_total"></span></div>
                <div style='margin-top:20px'>
                    <button class="btn-confirm-booking btn btn-primary" id="confirmBookingBtn">Confirm Booking / Move to Guest Info</button>
                    <button class="btn btn-primary" id="editConfirmBookingBtn">Edit</button>
                </div>
            </div>          
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="bookingHotelRoomModalClose">Close</button>
      </div>

    </div>
  </div>
</div>
<!-- End bookingHotelRoomModal -->

<!-- completeBookingGuestInfoModal is to complete booking with guest info -->
<div class="modal" id="completeBookingGuestInfoModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"></h4>
        <button type="button" class="close" data-dismiss="modal" id="completeBookingGuestInfoModalCloseOnX">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="confirmRoom_modalBody">
            <div class="col">
                
				<div class="container border rounded" style="margin:auto;padding:50px;margin-top:50px;margin-bottom:50px">
				    <h3>Please add your guests info</h3>
				    <div class="form-row">
					    <div class="col-4">
					        First Name <input class="form-control" type="text" id="id_guestFirstName""/>
					    </div>
					    <div class="col-4">
					        Last Name <input class="form-control" type="text" id="id_guestLastName""/>
					    </div>
					    <div class="col-2">
					        Age <input class="form-control" type="number" id="id_guestAge""/>
					    </div>
					    <div class="col-2">
	                        Gender <input class="form-control" type="text" id="id_guestGender""/>
	                    </div>
				    </div>  <!-- end form-row -->
				    <br/>
				    <input class="btn-sm btn-primary" type="button" id="id_addGuestBtn" value="Add Guest"/>
				</div>  <!-- end container border rounded -->
				
				<h5>Your Guests</h5>
                <div id="listGuest" class="col-12 border rounded">
                    <table id="tblGuest" border="1" class="col-12 border rounded">
                        <tr> <th>First Name</th> <th>Last Name</th> <th>Age</th> <th>Gender</th> <th>Remove</th> </tr>
                    </table>
                </div>
                
                <div style='margin-top:20px'>
                    <button class="btn-complete-booking-guest-info btn btn-primary" id=completeBookingGuestInfoBtn>Complete My Booking!</button>
                </div>
            </div>  <!-- end modal col -->
      </div>  <!-- end modal body -->
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="completeBookingGuestInfoModalClose">Close</button>
      </div>
      
    </div>
  </div>
</div>
<!-- End completeBookingGuestInfoModal -->

<!-- hotelReviewsModal is to view reviews of a hotel -->
<div class="modal" id=hotelReviewsModal>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Hotel Reviews</h4>
        <button type="button" class="close" data-dismiss="modal" id="hotelReviewsModalCloseOnX">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id="hotelReivews_modalBody">
            <div class="col">
                <h5 id="id_avgUserRating"></h5>
                <div class="container border rounded" style="margin:auto;padding:50px;margin-top:50px;margin-bottom:50px">
                    <table id="tblReviews" border="1" class="col-12 border rounded">
                        <tr> <th>UserName</th> <th>User Rating</th> <th>Review</th> </tr>
                    </table>
                </div>  <!-- end container border rounded -->
                
            </div>  <!-- end modal col -->
      </div>  <!-- end modal body -->
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="hotelReviewsModalClose">Close</button>
      </div>
      
    </div>
  </div>
</div>
<!-- End hotelReviewsModal -->

<script>
var slider = document.getElementById("priceRange");
var output = document.getElementById("priceValue");
output.innerHTML = slider.value;
slider.oninput = function() {
    output.innerHTML = this.value;
}
</script>
</body>
</html>
