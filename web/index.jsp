<%--Kuzey Cimen - 1803189 - kc18182--%>
<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>
    <title>My Shop</title>
    <link rel="stylesheet" type="text/css" href="css/1803189_style.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="main">
<%--    Includes the products jsp page.--%>
    <jsp:include page="products.jsp"/>
    <input type="button" value="Basket" onclick="document.location = 'basket.jsp'"/>

    <%--    Artist search form.--%>
    <form action="index.jsp" method="get">
        <input type="text" name="artist" placeholder="Enter Artist Name" required/>
        <input type="submit" value="Search"/>
    </form>

    <%--    Gettings products where price is between ranges form.--%>
    <form action="index.jsp" method="get">
        <h3>Enter Price Range</h3>
        <input type="text" name="low" placeholder="Low" pattern="[0-9]+" required/>
        <input type="text" name="high" placeholder="High" pattern="[0-9]+" required/>
        <input type="submit" value="Search"/>
    </form>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
