<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
    <link type="text/css" href="/static/css/breizhcamp.css" rel="stylesheet" >

    <style type="text/css">
        html {
            background: none;
        }
    </style>

  <title><tiles:getAsString name="title" /></title>
</head>

<body>
	<tiles:insertAttribute name="content" />
</body>
</html>
