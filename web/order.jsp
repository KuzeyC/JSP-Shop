<%--Kuzey Cimen - 1803189 - kc18182--%>
<jsp:useBean id='basket'
             scope='session'
             class='shop.Basket'/>

<jsp:useBean id='db'
             scope='session'
             class='shop.ShopDB'/>

<html>
<head>
    <title>Order</title>
    <link rel="stylesheet" type="text/css" href="css/1803189_style.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="main">
    <%--Getting the parameter name from the url.--%>
    <%
    String cusName = request.getParameter("name");

    //Order is complete.
    if (cusName != null && !cusName.equals("")) {
        db.order(basket, cusName);
        basket.clearBasket();
    %>
    <h2> Dear <%= cusName %>! Thank you for your order. </h2>
        <%--Button to go back to index.--%>
    <input type="button" value="Home" onclick="document.location = 'index.jsp'"/>
    <%
    //Order is not complete.
    } else {
    %>
    <h2> Please go back and supply a name. </h2>
    <%--Button to go back to the basket.--%>
    <input type="button" value="Back" onclick="document.location = 'basket.jsp'">
    <%
     }
    %>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
