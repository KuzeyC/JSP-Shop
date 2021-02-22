<%--Kuzey Cimen - 1803189 - kc18182--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="shop.Product" %>

<jsp:useBean id='db'
             scope='session'
             class='shop.ShopDB'/>

<html>
<head>
    <title>Product</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="main">
    <%--Getting the parameter pid from the url. And the product with that pid.--%>
    <%
    String pid = request.getParameter("pid");
    Product product = db.getProduct(pid);
    //Product doesnt exist in the database.
    if (product == null) {
        %>
        <h2>Product does not exist.</h2>
        <%
        //Product exists in the database.
    } else {
        %>
        <div>
            <%--Details about the product.--%>
            <h2><%= product.title %>  by <%= product.artist %></h2>
            <img src="<%= product.fullimage %>"/>
            <p><%= product.description %></p>
            <p><%= String.format("%.2f", product.price / 100.0) %></p>

            <%--Adding a button to forward it to the basket page with the pid of the product as a parameter.--%>
            <input type="button" value="Add to Basket" onclick="document.location = '<%="basket.jsp?addItem=" + product.PID %>'">

            <%--Button for going to the index page.--%>
            <input type="button" value="Back" onclick="document.location = 'index.jsp'">
        </div>
        <%
    }
    %>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
