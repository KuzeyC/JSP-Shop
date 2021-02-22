<%--Kuzey Cimen - 1803189 - kc18182--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="shop.Product" %>
<jsp:useBean id='db'
             scope='session'
             class='shop.ShopDB'/>
<html>
<body>
    <%
        boolean isFirstTime = true;
        //Getting the parameter artist, low and high from the url.
        String artist = request.getParameter("artist");
        String low = request.getParameter("low");
        String high = request.getParameter("high");
        //If artist is not null.
        if (artist != null) {
            //For each product in the database.
            for (Product product : db.getAllProducts()) {
                if (product.artist.toLowerCase().equals(artist.toLowerCase())) {
                    //If the products artist is the same as the products artist in the for loop add it to the table as a row.if (isFirstTime) {
                    if (isFirstTime) {
                        //Create table only if there are results.
                        %>
                        <table>
                            <tr>
                                <th>Title</th>
                                <th>Artist</th>
                                <th>Price</th>
                                <th>Picture</th>
                            </tr>
                        <%
                    }
                    isFirstTime = false;
                    %>
                    <tr>
                        <td><%= product.title %></td>
                        <td><%= product.artist %></td>
                        <td><%= String.format("%.2f", product.price / 100.0) %></td>
                        <td><a href='<%="viewProduct.jsp?pid="+product.PID%>'> <img src="<%= product.thumbnail %>" alt="Thumbnail"/></a></td>
                    </tr>
                    <%
                }
            }
            if (isFirstTime) {
                %>
                <h2>None found.</h2>
                <%
            }
        //If low and high is not null.
        } else if (low != null && high != null) {
            int lowInt = Integer.parseInt(low);
            int highInt = Integer.parseInt(high);
            //For each product in the database.
            for (Product product : db.getAllProducts()) {
                if (product.price / 100.0 >= lowInt && product.price / 100.0 <= highInt) {
                    if (isFirstTime) {
                        //Create table only if there are results.
                        %>
                        <table>
                            <tr>
                                <th>Title</th>
                                <th>Artist</th>
                                <th>Price</th>
                                <th>Picture</th>
                            </tr>
                        <%
                    }
                    isFirstTime = false;
                    //If the products price is between the low and high add it to the table as a row.
                    %>
                    <tr>
                        <td><%= product.title %></td>
                        <td><%= product.artist %></td>
                        <td><%= String.format("%.2f", product.price / 100.0) %></td>
                        <td><a href='<%="viewProduct.jsp?pid="+product.PID%>'> <img src="<%= product.thumbnail %>" alt="Thumbnail"/></a></td>
                    </tr>
                    <%
                }
            }
            if (isFirstTime) {
                %>
                <h2>None found.</h2>
                <%
            }
        //If artist, low or high is empty; show all products as usual.
        } else {
            //Create table only if there are results.
            %>
            <table>
                <tr>
                    <th>Title</th>
                    <th>Artist</th>
                    <th>Price</th>
                    <th>Picture</th>
                </tr>
            <%
            for (Product product : db.getAllProducts()) {
            //Add it to the table as a row.
            %>
            <tr>
                <td><%= product.title %></td>
                <td><%= product.artist %></td>
                <td><%= String.format("%.2f", product.price / 100.0) %></td>
                <td><a href='<%="viewProduct.jsp?pid="+product.PID%>'><img src="<%= product.thumbnail %>" alt="Thumbnail"/></a></td>
            </tr>
            <%
            }
        }
    %>
</table>
<%--Button for going to the index page.--%>
<input type="button" value="Reset Table" onclick="document.location = 'index.jsp'"/>
</body>
</html>
