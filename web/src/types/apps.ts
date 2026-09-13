import type { LucideIcon } from 'lucide-react';

export type AppId = 'home' | 'phone' | 'contacts' | 'messages' | 'settings';

export type AppProps = {
  displayName: string;
  phoneNumber: string;
  onOpenApp: (appId: AppId) => void;
};

export type AppComponent = (props: AppProps) => JSX.Element;

export type AppDefinition = {
  id: AppId;
  label: string;
  icon: LucideIcon;
  component: AppComponent;
};

export type AppDefinitions = Record<AppId, AppDefinition>;
