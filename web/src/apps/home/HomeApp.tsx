import type { AppProps } from '../../types/apps';
import type { AppId } from '../../types/apps';

const quickApps: AppId[] = ['phone', 'contacts', 'messages', 'settings'];

export function HomeApp({ displayName, phoneNumber, onOpenApp }: AppProps) {
  return (
    <section className="app-view home-app" aria-label="Home">
      <div className="home-identity">
        <p>{displayName}</p>
        <strong>{phoneNumber}</strong>
      </div>

      <div className="home-grid" aria-label="Applications">
        {quickApps.map((appId) => (
          <button
            className={`home-tile home-tile-${appId}`}
            key={appId}
            type="button"
            onClick={() => onOpenApp(appId)}
          >
            <span>{appId}</span>
          </button>
        ))}
      </div>
    </section>
  );
}
