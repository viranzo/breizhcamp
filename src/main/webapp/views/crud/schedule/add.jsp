<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type='text/javascript' charset='utf-8'>
         setActive('schedules');
</script>
<form action="/crud/schedule/add/submit.htm" method="post" class="form-horizontal span3">
<fieldset>
    <legend>Ajout d'un cr&eacute;neau</legend>
    <div class="control-group <c:if test='${not empty dateError}'>error</c:if>">
        <label class="control-label" for="date">Date du cr&eacute;neau</label>
        <div class="controls">
            <script type='text/javascript' charset='utf-8'>
                $(function() {
                    setTimeout( function() { $('#date').focus() }, 0 );
                });
            </script>
            <select id="date" name="date" class="input-xlarge" tabindex="1">
                <c:forEach var="uneDate" items="${possibleDates}">
                    <option value="${uneDate.sortieDate}" <c:if test="${date == uneDate.sortieDate}">selected="selected"</c:if>>${uneDate.sortieFr}</option>
                </c:forEach>
            </select>
            <c:if test='${not empty dateError}'>
                <span class="help-inline">${dateError}</span>
            </c:if>
        </div>
    </div>
    <div class="control-group <c:if test='${not empty startTimeError}'>error</c:if>">
        <label class="control-label" for="startTime">Heure de d&eacute;but du cr&eacute;neau</label>
        <div class="controls">
            <input type="time" id="startTime" name="startTime" class="input-xlarge" tabindex="2"
                <c:if test='${not empty startTime}'>value="${startTime}"</c:if>/>
            <c:if test='${not empty startTimeError}'>
                <span class="help-inline">${startTimeError}</span>
            </c:if>
        </div>
    </div>
    <div class="control-group <c:if test='${not empty roomError}'>error</c:if>">
        <label class="control-label" for="theme">Salle du cr&eacute;neau</label>
        <div class="controls">
            <select id="room" name="room" class="input-xlarge" tabindex="3">
                <option value="-1">Toutes salles</option>
                <c:forEach var="aRoom" items="${allRooms}">
                    <option value="${aRoom.id}"
                        <c:if test="${aRoom.id == room}">selected="selected"</c:if>>${aRoom.name}</option>
                </c:forEach>
            </select>
            <c:if test="${not empty roomError}">
                <span class="help-inline">${roomError}</span>
            </c:if>
        </div>
    </div>
    <div class="form-actions">
        <button type="submit" class="btn btn-primary" tabindex="4">Submit</button>
    </div>
</fieldset>
</form>


