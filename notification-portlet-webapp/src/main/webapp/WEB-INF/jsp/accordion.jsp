<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>

<jsp:directive.include file="/WEB-INF/jsp/include.jsp"/>

<c:set var="n"><portlet:namespace/></c:set>

<portlet:actionURL var="invokeNotificationServiceUrl" escapeXml="false">
    <portlet:param name="uuid" value="${uuid}"/>
    <portlet:param name="action" value="invokeNotificationService"/>
</portlet:actionURL>
<portlet:actionURL var="hideErrorUrl" escapeXml="false">
    <portlet:param name="action" value="hideError"/>
    <portlet:param name="errorKey" value="ERRORKEY"/>
</portlet:actionURL>

<script src="<rs:resourceURL value="/rs/jquery/1.6.1/jquery-1.6.1.min.js"/>" type="text/javascript"></script>
<script src="<rs:resourceURL value="/rs/jqueryui/1.8.13/jquery-ui-1.8.13.min.js"/>" type="text/javascript"></script>
<script src="<c:url value="/scripts/underscore.min.js"/>" type="text/javascript"></script>
<script src="<c:url value="/scripts/jquery.accordion.js"/>" type="text/javascript"></script>
<script src="<c:url value="/scripts/jquery.notifications.js"/>" type="text/javascript"></script>

<link rel="stylesheet" href="<c:url value="/styles/accordion.css"/>" type="text/css" media="screen" />

<div id="${n}container" class="notification-portlet">

    <!-- options menu -->
    <div class="notification-options" style="display: none;">
        <p class="notification-date-filter">
            View: <a class="all" href="#">All</a> | <a class="today active" href="#">Today</a>
        </p>
        <p class="notification-refresh"><a href="#">Refresh</a></p>
    </div>

    <!-- loading -->
    <div class="notification-loading"></div>
  
        <!-- notifications -->
        <div class="notification-portlet-wrapper" style="display: none;">
            
        <!-- accordion -->
        <div class="notification-container accordion"></div>

            <!-- detail view -->
            <div class="notification-detail-wrapper" style="display: none;">
                <div class="notification-back-button">
                    <span>Back</span>
                </div>
                <div class="notification-detail-container"></div>
            </div>

            <!-- errors -->
            <div class="notification-error-container" style="display: none;"></div>
  
     </div>

</div>

<!-- call ajax on dynamic portlet id -->
<script type="text/javascript">
    var ${n} = ${n} || {};
    ${n}.jQuery = jQuery.noConflict(true);
    ${n}.jQuery(document).ready(function () { 
        ${n}.jQuery("#${n}container").notifications({ 
            invokeNotificationServiceUrl: '${invokeNotificationServiceUrl}',
            getNotificationsUrl: '<portlet:resourceURL id="GET-NOTIFICATIONS"/>',
            hideErrorUrl: '${hideErrorUrl}'
        });
    });
</script>