﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myTrips.aspx.cs" Inherits="TripAdvisor.Views.myTrips" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet"
        id="theme_link"
        href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.1/lux/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <title>My Trips</title>
    <style>
        label {
            font-size: larger;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
                <div class="container-fluid">
                    <a runat="server" id="UserNameIfLogged" class="navbar-brand" href="#">TripAdvisor</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarColor01">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <a class="nav-link active" href="main.aspx">Home
                         <span class="visually-hidden">(current)</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" href="#">Login</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#">Separated link</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <!---Trip Box with payment info--->
            <div class="container">
                <div class="row" style="margin-top: 20px">
                    <asp:Repeater ID="repBooked" runat="server">
                        <HeaderTemplate></HeaderTemplate>
                        <ItemTemplate>
                            <div class="card shadow-sm" style="max-width: 25rem; margin-left: 12px;">
                                <img src="<%# Eval("PhotoPath")%>" class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("Name")%></h5>
                                    <hr>
                                    <div class="row">
                                        <div class="col">
                                            <strong>Checkin:</strong>
                                            <p class="card-text"><%# Eval("Checkin")%></p>
                                        </div>
                                        <div class="col">
                                            <strong>Checkout:</strong>
                                            <p class="card-text"><%# Eval("Checkout")%></p>
                                        </div>
                                        <div class="col">
                                            <strong>Hour:</strong>
                                            <p class="card-text"><%# Eval("BookedHour")%></p>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col">
                                            <strong>Adults:</strong> <%# Eval("Adults")%>
                                        </div>
                                        <div class="col">
                                            <strong>Total:</strong> $<label><%# Eval("Total")%></label>
                                        </div>
                                    </div>
                                    <hr>
                                    <p class="card-text"><small class="text-muted">Created: <%# Eval("Created")%></small></p>
                                    <button id="btnDelete" runat="server" type="button" dataid='<%# Eval("BookedId")%>' onserverclick="btnDelete_ServerClick" class="btn btn-danger">Delete</button>
                                    <button id="btnPayment" type="button" data-bs-toggle="offcanvas" data-bs-target="#paymentOffcanvas" class="btn btn-primary">Payment</button>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate></FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </form>
    <!-- Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="paymentOffcanvas" aria-labelledby="paymentOffcanvasLabel">
        <div class="offcanvas-header">
            <h5 id="paymentOffcanvasLabel">Payment Information</h5>
            <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <div class="container">
                <div id="tripList">
                    <!-- Trips will be dynamically added here -->
                </div>
                <hr>
                <div id="totalAmount">
                    <strong>Total Amount: </strong>$<span id="total"></span>
                </div>
                <hr>
                <div id="paymentForm">
                    <div class="form-group">
                        <div class="form-floating mb-4">
                            <input type="text" class="form-control" id="name" name="name" required>
                            <label for="name">Name on Card</label>
                        </div>
                        <div class="form-floating mb-4">
                            <input type="number" class="form-control" id="card_number" name="card_number" required>
                            <label for="card_number">Card Number</label>
                        </div>
                        <div class="form-floating mb-4">
                            <input type="text" class="form-control" id="expiration_date" name="expiration_date" pattern="(0[1-9]|1[0-2])\/[0-9]{2}" placeholder="MM/YY" required>
                            <label for="expiration_date">Expiration Date (MM/YY)</label>
                            <div class="invalid-feedback">Please enter a valid expiration date in the format MM/YY</div>
                        </div>

                        <div class="form-floating mb-4">
                            <input type="number" class="form-control" id="cvv" name="cvv" required>
                            <label for="cvv">CVV</label>
                        </div>
                        <a href="myPayment.aspx" class="btn btn-success mt-3">Pay Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script>
        // JavaScript to dynamically populate trip list and calculate total amount
        window.onload = function () {
            var tripItems = document.querySelectorAll('.trip-info');
            var tripList = document.getElementById('tripList');
            var totalAmount = 0;

            tripItems.forEach(function (item) {
                var tripName = item.querySelector('.card-title').textContent;
                var tripTotal = parseFloat(item.querySelector('label').textContent.replace('$', ''));
                totalAmount += tripTotal;

                var tripInfo = document.createElement('div');
                tripInfo.classList.add('trip-item');
                tripInfo.innerHTML = '<h5 class="card-title">' + tripName + '</h5><strong>Total:</strong> $' + tripTotal.toFixed(2);
                tripList.appendChild(tripInfo);
            });

            // Update total amount
            document.getElementById('total').textContent = totalAmount.toFixed(2);
        };
    </script>
</body>
</html>
