import { useEffect } from 'react';

type NuiMessage = {
  type: string;
};

export function useNuiEvent<TMessage extends NuiMessage>(
  type: TMessage['type'],
  handler: (message: TMessage) => void
) {
  useEffect(() => {
    const listener = (event: MessageEvent<TMessage>) => {
      if (!event.data || event.data.type !== type) {
        return;
      }

      handler(event.data);
    };

    window.addEventListener('message', listener);

    return () => {
      window.removeEventListener('message', listener);
    };
  }, [handler, type]);
}
