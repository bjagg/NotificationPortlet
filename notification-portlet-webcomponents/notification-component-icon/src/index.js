import NotificationIcon from './NotificationIcon';
import registerReact from '@christianmurphy/reactive-elements';

// register i18next
import './i18n';

// register icons
import {library} from '@fortawesome/fontawesome-svg-core';
import {faBell} from '@fortawesome/free-solid-svg-icons/faBell';
library.add(faBell);

registerReact('notification-icon', NotificationIcon);
