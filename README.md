# Home Assistant Add-on: vscode

> [!CAUTION]
> This add-on is still in early development. Use at your own risk.

A [Home Assistant] add-on for vscode ([code-server]) with build-in support for SSH.

This add-on combines elements of of [hassio-addons/addon-ssh] and [hassio-addons/addon-vscode] to create an all-in-one addition to your [Home Assistant] server.

## Development

### Local Testing

1. Open project in it's dev container.

1. From the command palette, run `Tasks: Run Task` then select `Start Home Assistant`.

1. Navigate to [http://localhost:7123](http://localhost:7123/) for the local development instance of [Home Assistant].

   1. [Add-ons Dashboard](http://localhost:7123/hassio/dashboard)
   1. [Add-on Store](http://localhost:7123/hassio/store)

> [!NOTE]
> See [Local add-on testing](https://developers.home-assistant.io/docs/add-ons/testing) for more details.

[code-server]: https://github.com/coder/code-server
[hassio-addons/addon-ssh]: https://github.com/hassio-addons/addon-ssh
[hassio-addons/addon-vscode]: https://github.com/hassio-addons/addon-vscode
[home assistant]: https://www.home-assistant.io/
