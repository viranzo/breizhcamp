<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="/WEB-INF/custom-functions.tld" prefix="custo" %>

<link rel='stylesheet' type='text/css' href='static/css/fullcalendar.css' />
<script type='text/javascript' src='/static/js/breizhcamp.js'></script>
<script type='text/javascript' src='static/js/fullcalendar.js'></script>

<script type='text/javascript' charset='utf-8'>
    setActive('programme');

    $(document).ready(function() {
        <c:forEach var="date" items="${dates}">

        var d = <fmt:formatDate value="${date}" type="both" pattern="d" />;
        var m = <fmt:formatDate value="${date}" type="both" pattern="MM" /> - 1;
        var y = <fmt:formatDate value="${date}" type="both" pattern="yyyy" />;
        var talks = [];

		$('#calendar<fmt:formatDate value="${date}" type="both" pattern="ddMMyyyy" />').fullCalendar({
            defaultView: 'agendaDay',
            slotMinutes: 15,
            header: {
                left:   '',
                center: '',
                right: ''
            },
            titleFormat: {
                day: ''
            },
            columnFormat: {
                day: ''
            },
            allDaySlot: false,
            minTime: ${bornes[date].min},
            maxTime: ${bornes[date].max},
	        axisFormat: 'HH:mm',
	        contentHeight:10000,
	        height:10000,
            timeFormat: {
                agenda: 'HH:mm{ - HH:mm}'
            },
            events: [
                <c:forEach var="talk" items="${talks[date]}" varStatus="status">
                {
                    title: "<c:if test="${not empty talk.schedule.room}">${talk.schedule.room.name}</c:if><c:if test="${empty talk.schedule.room}">Toutes salles</c:if> <c:if test="${talk.schedule.duree >= 60}">\n</c:if>${custo:formatchaine(talk.title)}",
					start: new Date(y, m, d, <fmt:formatDate value="${talk.schedule.start}" type="both" pattern="HH,mm"/>),
					end: new Date(y, m, d, <fmt:formatDate value="${custo:getfin(talk.schedule.start, talk.schedule.duree)}" type="both" pattern="HH,mm"/>),
					id : "${talk.id}",
                    allDay: false
                    <c:if test="${talk.theme != 'BREAK'}">
                        ,url: '/talk/${talk.id}.htm<c:if test="${hide}">?hide=true</c:if>'
                    </c:if>
                    <c:if test="${talk.duree == 15}">,color:'green'</c:if>
                    <c:if test="${talk.duree == 30}">,color:'#1010CA'</c:if>
                    <c:if test="${talk.duree == 60}">,color:'#e55c0c'</c:if>
                    <c:if test="${talk.duree == 180}">,color:'#660066'</c:if>
                    <c:if test="${talk.theme == 'BREAK'}">,color:'#EEEEEE',
                                                    textColor:'#000000'</c:if>
                }<c:if test="${not status.last}">,</c:if>
                </c:forEach>
            ]

        })

        $('#calendar<fmt:formatDate value="${date}" type="both" pattern="ddMMyyyy" />').fullCalendar(
            'gotoDate',
            <fmt:formatDate value="${date}" type="both" pattern="yyyy" />,
            <fmt:formatDate value="${date}" type="both" pattern="MM" /> - 1,
             <fmt:formatDate value="${date}" type="both" pattern="dd" />);

        <c:forEach var="talk" items="${talks[date]}" varStatus="status">
            talks.push(${talk.id});
        </c:forEach>

        </c:forEach>

        initFavorisOnCalendar(talks);

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


