# Home Assistant Add-on: vscode

[![release][releases-shield]][releases]
![supports aarch64 architecture][aarch64-shield]
![supports amd64 architecture][amd64-shield]
![project stage][project-stage-shield]
![maintenance][maintenance-shield]
[![license][license-shield]](./LICENSE)

[![Open this add-on in your Home Assistant instance][addon-badge]][addon]

This add-on runs Visual Studio Code, allowing you to edit your [Home Assistant] configuration straight from the web browser, embedded straight into the [Home Assistant] frontend UI, or via SSH.

Visual Studio Code runs as a remote server using [code-server], and is a full fledged vscode experience.

This add-on combines elements of of [hassio-addons/addon-ssh] and [hassio-addons/addon-vscode] to create an all-in-one addition to your [Home Assistant] server.

[:books: Read the full add-on documentation][docs]

## Support

Got questions?

Open an [issue on GitHub][issues].
Note, we use a separate GitHub repository for each add-on.
Please ensure you are creating the issue on the correct GitHub repository matching the add-on.

## Contributing

This is an active open-source project.
We are always open to people who want to use the code or contribute to it.

We have set up a separate document containing our [contribution guidelines](.github/CONTRIBUTING.md).

Thank you for being involved!

## Development

### Local Testing

1. Open project in it's dev container.

1. From the command palette, run `Tasks: Run Task` then select `Start Home Assistant`.

1. Navigate to [http://localhost:7123](http://localhost:7123/) for the local development instance of [Home Assistant].

   1. [Add-ons Dashboard](http://localhost:7123/hassio/dashboard)
   1. [Add-on Store](http://localhost:7123/hassio/store)

> [!NOTE]
> See [Local add-on testing](https://developers.home-assistant.io/docs/add-ons/testing) for more details.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[addon]: https://my.home-assistant.io/redirect/supervisor_addon/?addon=4b9bfde2_vscode&repository_url=https%3A%2F%2Fgithub.com%2Ffinleyfamily%2Fhass-repository
[addon-badge]: https://my.home-assistant.io/badges/supervisor_addon.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[code-server]: https://github.com/coder/code-server
[docs]: https://github.com/repository/blob/master/vscode/DOCS.md
[hassio-addons/addon-ssh]: https://github.com/hassio-addons/addon-ssh
[hassio-addons/addon-vscode]: https://github.com/hassio-addons/addon-vscode
[home assistant]: https://www.home-assistant.io/
[issues]: https://github.com/finleyfamily/hass-addon-vscode/issues
[license-shield]: https://img.shields.io/github/license/finleyfamily/hass-addon-vscode.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2024.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[releases]: https://github.com/finleyfamily/hass-addon-vscode/releases
[releases-shield]: https://img.shields.io/github/release/finleyfamily/hass-addon-vscode.svg
