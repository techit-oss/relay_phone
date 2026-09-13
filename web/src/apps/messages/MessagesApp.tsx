import { Edit3, Search } from 'lucide-react';
import type { AppProps } from '../../types/apps';

export function MessagesApp(_: AppProps) {
  return (
    <section className="app-view stack-view" aria-label="Messages">
      <header className="view-header row-header">
        <div>
          <p>Messages</p>
          <strong>Inbox</strong>
        </div>
        <button className="icon-button" type="button" aria-label="New message" disabled>
          <Edit3 size={18} />
        </button>
      </header>

      <label className="search-field">
        <Search size={16} />
        <input type="search" placeholder="Search" disabled />
      </label>

      <div className="empty-state">
        <strong>No conversations</strong>
        <p>Messages will appear here.</p>
      </div>
    </section>
  );
}
