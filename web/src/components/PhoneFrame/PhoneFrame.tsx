import { BatteryMedium, Signal, Wifi } from 'lucide-react';
import type { PropsWithChildren } from 'react';
import type { AppDefinitions, AppId } from '../../types/apps';

type PhoneFrameProps = PropsWithChildren<{
  activeApp: AppId;
  apps: AppDefinitions;
  displayName: string;
  phoneNumber: string;
  onAppChange: (appId: AppId) => void;
}>;

const dockApps: AppId[] = ['phone', 'contacts', 'messages', 'settings'];

export function PhoneFrame({
  activeApp,
  apps,
  children,
  displayName,
  phoneNumber,
  onAppChange
}: PhoneFrameProps) {
  return (
    <section className="phone-frame" aria-label="Relay Phone">
      <div className="phone-hardware">
        <div className="phone-screen">
          <header className="status-bar">
            <span>Relay</span>
            <div className="status-icons" aria-label="Status">
              <Signal size={14} />
              <Wifi size={14} />
              <BatteryMedium size={16} />
            </div>
          </header>

          <div className="screen-content">{children}</div>

          <nav className="phone-dock" aria-label="Dock">
            {dockApps.map((appId) => {
              const app = apps[appId];
              const Icon = app.icon;

              return (
                <button
                  aria-label={app.label}
                  className={activeApp === appId ? 'is-active' : ''}
                  key={app.id}
                  type="button"
                  title={app.label}
                  onClick={() => onAppChange(appId)}
                >
                  <Icon size={21} />
                </button>
              );
            })}
          </nav>
        </div>
      </div>

      <div className="phone-shadow" aria-hidden="true" />
      <span className="sr-only">
        {displayName} {phoneNumber}
      </span>
    </section>
  );
}
