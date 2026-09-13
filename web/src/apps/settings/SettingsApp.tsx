import { Bell, Moon, ShieldCheck } from 'lucide-react';
import type { AppProps } from '../../types/apps';

const settings = [
  { label: 'Silent Mode', icon: Bell },
  { label: 'Dim Wallpaper', icon: Moon },
  { label: 'Secure Identity', icon: ShieldCheck }
];

export function SettingsApp(_: AppProps) {
  return (
    <section className="app-view stack-view" aria-label="Settings">
      <header className="view-header">
        <p>Settings</p>
        <strong>Relay</strong>
      </header>

      <div className="settings-list">
        {settings.map((setting) => {
          const Icon = setting.icon;

          return (
            <label className="setting-row" key={setting.label}>
              <span className="setting-label">
                <Icon size={18} />
                {setting.label}
              </span>
              <input type="checkbox" disabled={setting.label === 'Secure Identity'} />
            </label>
          );
        })}
      </div>
    </section>
  );
}
