<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Onglets -->
<ul class="nav  nav-tabs">
    <li id="programme"><a href="/index.htm">Programme</a></li>
    <li id="speakers"><a href="/speakers.htm">Speakers</a></li>
    <li id="github"><a href="https://github.com/BreizhJUG/breizhcamp" target="_blank">GitHub</a></li>
    <li id="breizhjug"><a href="http://www.breizhjug.org/" target="_blank">BreizhJug</a></li>
    <li id="contact"><a href="/contact.htm">Contact</a></li>
</ul>

<!-- Liens de navigation -->
<div style="position: fixed;top:2px;right:10px">
    <a href="<c:url value='/index.htm'/>">Home</a>&nbsp;&nbsp;
    <a href="<c:url value='/crud/room/index.htm'/>">Admin</a>
</div>
