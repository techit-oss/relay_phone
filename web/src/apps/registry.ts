import { ContactRound, Home, MessageCircle, Phone, Settings } from 'lucide-react';
import { ContactsApp } from './contacts/ContactsApp';
import { HomeApp } from './home/HomeApp';
import { MessagesApp } from './messages/MessagesApp';
import { PhoneApp } from './phone/PhoneApp';
import { SettingsApp } from './settings/SettingsApp';
import type { AppDefinitions, AppId } from '../types/apps';

export const appRegistry = {
  home: {
    id: 'home',
    label: 'Home',
    icon: Home,
    component: HomeApp
  },
  phone: {
    id: 'phone',
    label: 'Phone',
    icon: Phone,
    component: PhoneApp
  },
  contacts: {
    id: 'contacts',
    label: 'Contacts',
    icon: ContactRound,
    component: ContactsApp
  },
  messages: {
    id: 'messages',
    label: 'Messages',
    icon: MessageCircle,
    component: MessagesApp
  },
  settings: {
    id: 'settings',
    label: 'Settings',
    icon: Settings,
    component: SettingsApp
  }
} satisfies AppDefinitions;

export type { AppId };
