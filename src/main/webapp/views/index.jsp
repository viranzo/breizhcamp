<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="/WEB-INF/custom-functions.tld" prefix="custo" %>

<link rel='stylesheet' type='text/css' href='static/css/fullcalendar.css' />
<script type='text/javascript' src='static/js/fullcalendar.js'></script>

<script type='text/javascript' charset='utf-8'>
    setActive('programme');

    $(document).ready(function() {
        <c:forEach var="date" items="${dates}">

        var d = <fmt:formatDate value="${date}" type="both" pattern="d" />;
        var m = <fmt:formatDate value="${date}" type="both" pattern="MM" /> - 1;
        var y = <fmt:formatDate value="${date}" type="both" pattern="yyyy" />;

		$('#calendar<fmt:formatDate value="${date}" type="both" pattern="ddMMyyyy" />').fullCalendar({
            defaultView: 'agendaDay',
            header: {
                left:   '',
                center: '',
                right: ''
            },
            minTime: 8,
            maxTime: 20,
	        axisFormat: 'hh:mm',
            timeFormat: {
                agenda: 'hh:mm{ - hh:mm}'
            },
            events: [
                <c:forEach var="talk" items="${talks[date]}" varStatus="status">
                {
                    title: '<c:if test="${not empty talk.schedule.room}">Salle ${talk.schedule.room.name}</c:if><c:if test="${empty talk.schedule.room}">Toutes salles</c:if>\n${talk.title}',
					start: new Date(y, m, d, <fmt:formatDate value="${talk.schedule.start}" type="both" pattern="HH,mm"/>),
					end: new Date(y, m, d, <fmt:formatDate value="${custo:getfin(talk.schedule.start, talk.schedule.duree)}" type="both" pattern="HH,mm"/>),
                    allDay: false,
                    url: '/talk/${talk.id}.htm<c:if test="${hide}">?hide=true</c:if>'
                }<c:if test="${not status.last}">,</c:if>
                </c:forEach>
            ]

        })

        $('#calendar<fmt:formatDate value="${date}" type="both" pattern="ddMMyyyy" />').fullCalendar(
            'gotoDate',
            <fmt:formatDate value="${date}" type="both" pattern="yyyy" />,
            <fmt:formatDate value="${date}" type="both" pattern="MM" /> - 1,
             <fmt:formatDate value="${date}" type="both" pattern="dd" />);

        </c:forEach>

    });
</script>

<c:forEach var="date" items="${dates}">
    <fieldset>
        <legend><spring:message code="programme.title" text="default text" /> <fmt:formatDate value="${date}" type="both" pattern="dd/MM/yyyy" /></legend>
        <div id='calendar<fmt:formatDate value="${date}" type="both" pattern="ddMMyyyy" />'></div>
    </fieldset>
</c:forEach>
<fieldset  class="span${fn:length(rooms)*2+2} baspage" >
</fieldset>


