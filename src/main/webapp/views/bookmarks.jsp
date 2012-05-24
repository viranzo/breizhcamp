<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type='text/javascript' charset='utf-8'>
    $(document).ready(function() {
        setActive('bookmarks');
        initBookmarksPage();
    });
</script>

<h3><spring:message code="bookmarks.title" text="default text" /></h3>
<div id="bookmarks-page-content"></div>
