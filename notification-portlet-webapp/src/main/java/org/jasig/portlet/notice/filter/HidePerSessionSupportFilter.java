package org.jasig.portlet.notice.filter;

import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jasig.portlet.notice.INotificationServiceFilterChain;
import org.jasig.portlet.notice.NotificationCategory;
import org.jasig.portlet.notice.NotificationEntry;
import org.jasig.portlet.notice.NotificationResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class HidePerSessionSupportFilter extends AbstractNotificationServiceFilter {

    public static final String SESSION_ATTR_PREFIX = HidePerSessionSupportFilter.class.getName() + ".timestamp";

    private Logger log = LoggerFactory.getLogger(getClass());

    public HidePerSessionSupportFilter() {
        super(AbstractNotificationServiceFilter.ORDER_NORMAL);
    }

    private boolean readEnabled(PortletRequest request) {
        PortletPreferences prefs = request.getPreferences();
        return Boolean.valueOf(prefs.getValue(READ_ENABLED_PREFERENCE, DEFAULT_READ_BEHAVIOR));
    }

    @Override
    public NotificationResponse doFilter(HttpServletRequest request, INotificationServiceFilterChain chain) {

        final HttpSession session = request.getSession(true);
        final NotificationResponse response = chain.doFilter().cloneIfNotCloned();
        request.getParameter()

        for (NotificationCategory category : response.getCategories()) {
            final List<NotificationEntry> newEntries = new ArrayList<>();
            for (NotificationEntry entry : category.getEntries()) {
                log.debug("entry: {}", entry);
                if (hasEntryBeenSeen(session, entry)) {
                    log.debug("entry {} has been seen.", entry.getId());
                    continue;
                }
                markSessionForEntry(session, entry);
                log.debug("session marked for entry {}", entry.getId());
                newEntries.add(entry);
            }
            category.setEntries(newEntries);
        }

        return response;
    }

    private static String getEntryAttrName(NotificationEntry entry) {
        return SESSION_ATTR_PREFIX + entry.getId();
    }
    private static boolean hasEntryBeenSeen(HttpSession session, NotificationEntry entry) {
        return session.getAttribute(getEntryAttrName(entry)) != null;
    }

    private static void markSessionForEntry(HttpSession session, NotificationEntry entry) {
        session.setAttribute(getEntryAttrName(entry), System.currentTimeMillis());
    }

}
