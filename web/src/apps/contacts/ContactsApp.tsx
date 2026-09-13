import { Plus, Search } from 'lucide-react';
import type { AppProps } from '../../types/apps';

export function ContactsApp(_: AppProps) {
  return (
    <section className="app-view stack-view" aria-label="Contacts">
      <header className="view-header row-header">
        <div>
          <p>Contacts</p>
          <strong>Directory</strong>
        </div>
        <button className="icon-button" type="button" aria-label="Add contact" disabled>
          <Plus size={18} />
        </button>
      </header>

      <label className="search-field">
        <Search size={16} />
        <input type="search" placeholder="Search" disabled />
      </label>

      <div className="empty-state">
        <strong>No contacts</strong>
        <p>Saved people will appear here.</p>
      </div>
    </section>
  );
}
