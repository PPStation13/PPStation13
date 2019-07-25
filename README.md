## PP Station 13 [![GitHub forks](https://img.shields.io/github/forks/HippieStation/HippieStation.svg?style=social&label=Fork)](https://github.com/HippieStation/HippieStation#fork-destination-box)

**Website:** http://pp13.space/ <BR>
**Code:** https://github.com/PPStation13/PPStation13 <BR>
**Wiki** https://wiki.hippiestation.com/index.php?title=Main_Page for now...<BR>

Anime is bad...

## ABOUT

This is the Github page for the PP Station codebase, used on the Space Station 13 server. This codebase is built off the work of many different servers, primarily that of /tg/station 13 and Hippie Station 13.
Because of this, the repository inherits /tg/station's licensing, among other things.
For a full guide on how to set up your own Space Station 13 server, please see the [/tg/station README.md](https://github.com/tgstation/tgstation/blob/master/README.md).
If you would like to contribute to this codebase, first take a look at the [CONTRIBUTING.md](.github/CONTRIBUTING.md).
**Website:** https://www.tgstation13.org
**Code:** https://github.com/tgstation/tgstation
**Wiki** https://tgstation13.org/wiki/Main_Page
**IRC:** no one uses IRC anymore but irc://irc.rizon.net/coderbus or if you dont have an IRC client, you can click  [here](https://kiwiirc.com/client/irc.rizon.net:6667/?&theme=cli#coderbus)

## DOWNLOADING

There are a number of ways to download the source code. Some are described here, an alternative all-inclusive guide is also located at https://wiki.hippiestation.com/index.php?title=Downloading_the_source_code

Option 1:
Follow this: https://wiki.hippiestation.com/index.php?title=Setting_up_git

Option 2: Download the source code as a zip by clicking the ZIP button in the
code tab of https://github.com/hippiestation/hippiestation
(note: this will use a lot of bandwidth if you wish to update and is a lot of
hassle if you want to make any changes at all, so it's not recommended.)

Option 3: Download a pre-compiled nightly at https://tgstation13.download/nightlies/ (same caveats as option 2)

Option 4: Use our docker image that tracks the master branch (See commits for build status. Again, same caveats as option 2)

```
docker run -d -p <your port>:1337 -v /path/to/your/config:/hippiestation/config -v /path/to/your/data:/hippiestation/data hippiestation/hippiestation <dream daemon options i.e. -public or -params>
```

## LICENSE

All code after [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.html).

All code before [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

See LICENSE and OLD_LICENSE-GPLv3.txt for more details.

tgui clientside is licensed as a subproject under the MIT license.
Font Awesome font files, used by tgui, are licensed under the SIL Open Font License v1.1
tgui assets are licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).
The TGS3 API is licensed as a subproject under the MIT license.

See tgui/LICENSE.md for the MIT license.
See tgui/assets/fonts/SIL-OFL-1.1-LICENSE.md for the SIL Open Font License.
See the footers of code/\_\_DEFINES/server\_tools.dm, code/modules/server\_tools/st\_commands.dm, and code/modules/server\_tools/st\_inteface.dm for the MIT license.

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
