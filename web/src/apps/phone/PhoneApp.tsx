import { Delete, PhoneCall } from 'lucide-react';
import type { AppProps } from '../../types/apps';

const keypad = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#'];

export function PhoneApp({ phoneNumber }: AppProps) {
  return (
    <section className="app-view stack-view" aria-label="Phone">
      <header className="view-header">
        <p>My Number</p>
        <strong>{phoneNumber}</strong>
      </header>

      <div className="dial-display" aria-label="Dialed number">
        <span> </span>
        <button className="icon-button" type="button" aria-label="Delete digit" disabled>
          <Delete size={18} />
        </button>
      </div>

      <div className="keypad" aria-label="Keypad">
        {keypad.map((digit) => (
          <button key={digit} type="button" disabled>
            {digit}
          </button>
        ))}
      </div>

      <button className="call-button" type="button" aria-label="Start call" disabled>
        <PhoneCall size={22} />
      </button>
    </section>
  );
}
