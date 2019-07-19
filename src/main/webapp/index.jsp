<%@ page import="com.salesforce.saml.Identity,com.salesforce.util.Bag,java.util.Set,java.util.Iterator,java.util.ArrayList" %>
<%
Identity identity = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
 for (Cookie cookie : cookies) {
   if (cookie.getName().equals("IDENTITY")) {
     identity = new Identity(cookie.getValue(),true);
    }
  }
}

%>

<html>

<head>
	<link href="/css/style.css" rel="stylesheet" type="text/css">
</head>

<body
	style="background-image: url('https://www.cervezaturia.es/sites/default/files/2018-12/home-header-ok.jpg'); background-position: center;   background-repeat: no-repeat;  background-size: cover; ">
	<div style="position: fixed;left: 50%;transform: translateX(-50%);top:10%;">

		<center>
			<img src="img/turia.svg" alt="Turia">
		</center>

		<div style="background-color:rgba(255,255,255,.5);padding:20px;margin-top:20px;">

			<% if (identity != null ) { %>
			<center>
				<h2><%= identity.getSubject() %></h2>
				<table border="0" cellpadding="5">
					<%
	Bag attributes = identity.getAttributes();
	Set keySet = attributes.keySet();
	Iterator iterator = keySet.iterator();
	while (iterator.hasNext()){
		String key = (String)iterator.next();
		%><tr>
						<td><b><%= key %>:</b></td>
						<td><%
		ArrayList<String> values = (ArrayList<String>)attributes.getValues(key);
		for (String value : values) {
			%><%= value %><br /><%
		}
		%></td>
					</tr><%

	}

%>
				</table>
				<br>
				<a href="/_saml?logout=true" class="button center">Logout</a>
				<a href="https://damm.zhopping.es/s/settings/" class="button center">Mis Datos</a>
				<%=attributes.get("userId")%>
			</center>
			<% } else {  %>
			<center>
				<div class="centered">
					<span class=""><a href="/_saml?RelayState=%2F" class="button center">Login</a></span>
				</div>
			</center>
			<% } %>

		</div>
	</div>

</body>

</html>