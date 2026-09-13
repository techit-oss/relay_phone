declare const GetParentResourceName: (() => string) | undefined;

export function isEnvBrowser() {
  return typeof GetParentResourceName === 'undefined';
}

function getResourceName() {
  if (typeof GetParentResourceName === 'function') {
    return GetParentResourceName();
  }

  return 'relay_phone';
}

function getBrowserMock<TResponse>(eventName: string): TResponse {
  if (eventName === 'relay_phone:getBootstrap') {
    return {
      ok: true,
      data: {
        identity: {
          displayName: 'Relay User',
          phoneNumber: '5550142'
        },
        framework: 'browser',
        apps: []
      }
    } as TResponse;
  }

  return { ok: true } as TResponse;
}

export async function fetchNui<TResponse = unknown>(
  eventName: string,
  payload: Record<string, unknown> = {}
): Promise<TResponse> {
  if (isEnvBrowser()) {
    return getBrowserMock<TResponse>(eventName);
  }

  const response = await fetch(`https://${getResourceName()}/${eventName}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: JSON.stringify(payload)
  });

  return response.json() as Promise<TResponse>;
}
