<%--Kuzey Cimen - 1803189 - kc18182--%>
<%@ page import="java.util.HashMap" %>
<%@ page import="shop.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id='basket'
             scope='session'
             class='shop.Basket'/>

<jsp:useBean id='db'
             scope='session'
             class='shop.ShopDB'/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="main">
    <%--Getting the parameter removeItem from the url.--%>
    <%
    String item = request.getParameter("removeItem");
    int amount = Integer.parseInt(request.getParameter("amount"));
    HashMap<Product, Integer> items = basket.getItems();

    if (item != null && !item.equals("")) {
        //Checking if that item is in th basket. If yes, remove that many items from that basket with the same title.
        for (Product p : items.keySet()) {
            if (p.title.toLowerCase().equals(item.toLowerCase())) {
                %>
                <h2><%= basket.remove(p, amount) + " " + p.title%> were removed from basket.</h2>

                <%--Buttons for going to index and basket.--%>
                <input type="button" value="Home" onclick="document.location = 'index.jsp'"/>
                <input type="button" value="Basket" onclick="document.location = 'basket.jsp'"/>
                <%
                return;
            }
        }
    %>

    <%--Item not in the basket.--%>
    <h2>Item not found in basket.</h2>
    <%
    }
    %>

    <%--Buttons for going to index and basket.--%>
    <input type="button" value="Home" onclick="document.location = 'index.jsp'"/>
    <input type="button" value="Basket" onclick="document.location = 'basket.jsp'"/>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>
