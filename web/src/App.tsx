import { useEffect, useMemo, useState } from 'react';
import { PhoneFrame } from './components/PhoneFrame/PhoneFrame';
import { appRegistry, type AppId } from './apps/registry';
import { useNuiEvent } from './hooks/useNuiEvent';
import { fetchNui, isEnvBrowser } from './services/nui';
import type { BootstrapResponse, RelayNuiMessage } from './types/nui';

export function App() {
  const [visible, setVisible] = useState(isEnvBrowser());
  const [activeApp, setActiveApp] = useState<AppId>('home');
  const [displayName, setDisplayName] = useState('Relay User');
  const [phoneNumber, setPhoneNumber] = useState('5550000');

  useNuiEvent<RelayNuiMessage>('relay_phone:setVisible', (message) => {
    setVisible(message.visible);

    if (message.visible) {
      setActiveApp('home');
    }
  });

  useEffect(() => {
    if (!visible) {
      return;
    }

    let isMounted = true;

    fetchNui<BootstrapResponse>('relay_phone:getBootstrap')
      .then((response) => {
        if (!isMounted || !response.ok) {
          return;
        }

        setDisplayName(response.data.identity.displayName ?? 'Relay User');
        setPhoneNumber(response.data.identity.phoneNumber);
      })
      .catch(() => undefined);

    return () => {
      isMounted = false;
    };
  }, [visible]);

  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      if (!visible || event.key !== 'Escape') {
        return;
      }

      fetchNui('relay_phone:close').catch(() => undefined);
      setVisible(false);
    };

    window.addEventListener('keydown', handleKeyDown);

    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [visible]);

  const ActiveApp = useMemo(() => appRegistry[activeApp].component, [activeApp]);

  return (
    <main className={`nui-root ${visible ? 'is-visible' : ''}`}>
      <PhoneFrame
        activeApp={activeApp}
        apps={appRegistry}
        displayName={displayName}
        phoneNumber={phoneNumber}
        onAppChange={setActiveApp}
      >
        <ActiveApp
          displayName={displayName}
          phoneNumber={phoneNumber}
          onOpenApp={setActiveApp}
        />
      </PhoneFrame>
    </main>
  );
}
