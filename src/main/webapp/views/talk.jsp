<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="custo" uri="/WEB-INF/custom-functions.tld" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script type='text/javascript' charset='utf-8'>
     $(document).ready(function() {
         setActive('programme');
         initFavoris();
         initTalkOnTalkPage(${talk.id});
     });
</script>

<fieldset class="span8">
    <legend>${talk.title}</legend>
    <table class="table  table-striped table-bordered table-condensed span6">
        <tr>
            <td class="span2"><spring:message code="resume.title" text="default text" /></td>
            <td class="span6">${talk.description}</td>
        </tr>
        <tr>
            <td><spring:message code="date.title" text="default text" /></td>
            <td><fmt:formatDate value="${talk.schedule.start}" type="both" pattern="dd/MM/yyyy" /></td>
        </tr>
        <tr>
            <td><spring:message code="heure.title" text="default text" /></td>
            <td>${custo:getdebut(talk.schedule.start)}</td>
        </tr>
        <tr>
            <td><spring:message code="duree.title" text="default text" /></td>
            <td>${custo:getduree(talk.duree)}</td>
        </tr>
        <tr>
            <td><spring:message code="theme.title" text="default text" /></td>
            <td><a href='/theme/${talk.theme}.htm<c:if test="${hide == true}">?hide=${hide}</c:if>'>${talk.theme.htmlValue}</a></td>
        </tr>
        <tr>
            <td><spring:message code="salle.title" text="default text" /></td>
            <td><c:if test="${empty talk.schedule.room}"><spring:message code="talk.all.room" text="default text" /></c:if>${talk.schedule.room.name}</td>
        </tr>
        <tr>
            <td><spring:message code="speakers.title" text="default text" /></td>
            <td>
                <c:forEach var="speaker" items="${talk.speakers}">
                    <a href='/speaker/${speaker.id}.htm<c:if test="${hide == true}">?hide=${hide}</c:if>'>${speaker.firstName} ${speaker.lastName}</a><br/>
                </c:forEach>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <button id="talk" id_talk="${talk.id}" class="btn btn-success" href="#"></button>
            </td>
        </tr>
    </table>
</fieldset>

<fieldset  class="span8 baspage" >
</fieldset>
