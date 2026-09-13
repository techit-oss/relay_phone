export type RelayNuiMessage = {
  type: 'relay_phone:setVisible';
  visible: boolean;
};

export type BootstrapResponse =
  | {
      ok: true;
      data: {
        identity: {
          phoneNumber: string;
          displayName?: string;
        };
        framework: string;
        apps: Array<{
          id: string;
          label: string;
          icon: string;
        }>;
      };
    }
  | {
      ok: false;
      error: string;
    };
