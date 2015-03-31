# cc-blue-api
Boilerplate ComputerCraft API

Warning: This project is currently under development and is prone to undocumented breaking changes until officially released.


#### Features:
- Internal moduler dependencies
- API's
 - File API
 - GitHub API
 - HTTP API
 - IO API
 - Startup API
 - Update API
- Automatic updates

#### Planned:
- API's
 - Drives API
 - Widgets API
 - Turtle API


### Install methods:


#### [BlueAPI Installer] (http://pastebin.com/yy7gqfBQ)

Usage:
pastebin run yy7gqfBQ [files..]

Files params should be relative paths of additional files to download.
If blank, all files will be downloaded.
Custom installation is currently slower because it uses synchronous http. Only use it if you need a few files.


#### [Ensure BlueAPI] (http://pastebin.com/xQfeXVgj)

Usage:
pastebin run xQfeXVgj [apis..]

Apis params should be names of additional api's to load.
If any are not found, they will be downloaded.
If none are provided, full api will be downloaded depending on the version, but only essentials will be loaded.
Essential api's are loaded regardless, but can be included.
