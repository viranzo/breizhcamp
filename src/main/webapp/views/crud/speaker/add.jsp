<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script type='text/javascript' charset='utf-8'>
         setActive('speakers');
</script>
<form action="/crud/speaker/add/submit.htm" method="post" class="form-horizontal span3">
<fieldset>
    <legend><spring:message code="speaker.add.title" text="default text" /></legend>
    <div class="control-group <c:if test='${not empty firstNameError}'>error</c:if>">
        <label class="control-label" for="firstName"><spring:message code="speaker.add.prenom.label" text="default text" /></label>
        <div class="controls">
            <script type='text/javascript' charset='utf-8'>
                $(function() {
                    setTimeout( function() { $('#firstName').focus() }, 0 );
                });
            </script>
            <input type="text" id="firstName" name="firstName" class="input-large" tabindex="1"
                <c:if test='${not empty firstName}'>value="${firstName}"</c:if>/>
            <c:if test='${not empty firstNameError}'>
                <span class="help-inline">${firstNameError}</span>
            </c:if>
        </div>
    </div>
    <div class="control-group <c:if test='${not empty lastNameError}'>error</c:if>">
        <label class="control-label" for="lastName"><spring:message code="speaker.add.nom.label" text="default text" /></label>
        <div class="controls">
            <input type="text" id="lastName" name="lastName" class="input-large" tabindex="2"
                <c:if test='${not empty lastName}'>value="${lastName}"</c:if>/>
            <c:if test='${not empty lastNameError}'>
                <span class="help-inline">${lastNameError}</span>
            </c:if>
        </div>
    </div>
    <div class="control-group <c:if test='${not empty twitterError}'>error</c:if>">
        <label class="control-label" for="twitter"><spring:message code="speaker.add.twitter.label" text="default text" /></label>
        <div class="controls">
            <input type="text" id="twitter" name="twitter" class="input-large" tabindex="3" onchange="changePicture()"
                <c:if test='${not empty twitter}'>value="${twitter}"</c:if>/>
            <c:if test='${not empty twitterError}'>
                <span class="help-inline">${twitterError}</span>
            </c:if>
        </div>
     </div>
    <div class="control-group <c:if test='${not empty descriptionError}'>error</c:if>">
        <label class="control-label" for="resume"><spring:message code="speaker.add.resume.label" text="default text" /></label>
        <div class="controls">
            <textarea type="textarea" id="description" name="description" rows="4" class="input-xlarge" tabindex="4"><c:if test='${not empty description}'>${description}</c:if></textarea>
            <c:if test='${not empty descriptionError}'>
                <span class="help-inline">${descriptionError}</span>
            </c:if>
        </div>
    </div>
    <div class="control-group <c:if test='${not empty pictureError}'>error</c:if>">
        <label class="control-label" for="picture"><spring:message code="speaker.add.photo.label" text="default text" /></label>
        <div class="controls">
            <script type='text/javascript' charset='utf-8'>
                function changePicture() {
                    if ($('#twitter').val() != ''  && $('#picture').val() == '') {
                        if( $('#twitter').val().indexOf('+') == -1) {
                            $('#picture').val('http://api.twitter.com/1/users/profile_image/' + $('#twitter').val() + '.xml?size=bigger');
                        } else{
                             $('#picture').val('https://profiles.google.com/s2/photos/profile/' + $('#twitter').val().substring(1, $('#twitter').val().length));
                        }
                    }
                };

            </script>
            <input type="text" id="picture" name="picture" class="input-large" tabindex="5"
                <c:if test='${not empty picture}'>value="${picture}"</c:if>/>
            <c:if test='${not empty pictureError}'>
                <span class="help-inline">${pictureError}</span>
            </c:if>
        </div>
    </div>
    <div class="form-actions">
        <button type="submit" class="btn btn-primary" tabindex="6"><spring:message code="action.submit" text="default text" /></button>
    </div>
</fieldset>
</form>



