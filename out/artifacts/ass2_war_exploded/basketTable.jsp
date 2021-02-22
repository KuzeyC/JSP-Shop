<%--Kuzey Cimen - 1803189 - kc18182--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="shop.Product" %>
<%@ page import="java.util.HashMap" %>
<jsp:useBean id='basket'
             scope='session'
             class='shop.Basket'/>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="css/1803189_style.css">
</head>
<body>
<table>
    <%--HashMap to store the product and the count.--%>
    <%
        HashMap<Product, Integer> items = basket.getItems();
    %>

    <%--Table headers.--%>
    <tr>
        <th>Thumbnail</th>
        <th>Title</th>
        <th>Price</th>
        <th>Artist</th>
        <th>Amount</th>
    </tr>
    <%--For each product in hashmap--%>
    <%
        for (Product item : items.keySet()) {
    %>
    <%--Table rows contents.--%>
    <tr>
        <td><img src="<%=item.thumbnail%>" alt="<%=item.title%> Thumbnail"/></td>
        <td><%=item.title%></td>
        <td><%=String.format("%.2f", item.price / 100.0)%></td>
        <td><%=item.artist%></td>
        <td><%=items.get(item)%></td>
    </tr>
    <% } %>
</table>
</body>
</html>
