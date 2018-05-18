# rcode

## Description

Visual Studio Code adds a nice feature, where it is possible to edit files on a remote server
using a helper script. The original helper script provided with TM2 is implemented in
ruby. Here is my attempt to replace this ruby script with a shell script, because in
some cases a ruby installation might just be too much overhead for just editing remote
files.

The shell script needs to be copied to the server, you want to remote edit files, on.
After that, open your TM2 preferences and enable "Allow rcode connections" setting in
the "Terminal" settings and adjust the setting "Access for" according to your needs:

### Quick install

```bash
sudo wget -O /usr/local/bin/rcode https://raw.github.com/prox33/rcode/master/rcode
sudo chmod a+x /usr/local/bin/rcode
```

### Local clients

It's a good idea to allow access only for local clients. In this case you need to open
a SSH connection to the system you want to edit a file on and specify a remote tunnel in
addition:

	ssh -R 52698:localhost:52698 user@example.com

If you are logged in on the remote system, you can now just execute

	rcode test.txt


### Remote clients

On some machines, where port forwarding is not possible, for example due to a missing ssh
daemon, you can allow access for "remote clients". Just ssh or telnet to the remote machine
and execute:

    rcode -H vscode-host test.txt

## Requirements

A bash with compiled support for "/dev/tcp" is required. This is not the case on some
older linux distributions, like Ubuntu 9.x.

## Usage

Edit specified file

    $ ./rcode [arguments] [--] file-path

Read text from stdin

    $ echo "hello Visual Studio Code" | ./rcode [arguments] -

### Arguments

    -H, --host HOST  Connect to HOST. Use 'auto' to detect the host from SSH.
    -p, --port PORT  Port number to use for connection.
    -w, --[no-]wait  Wait for file to be closed by Visual Studio Code.
    -l, --line LINE  Place caret on line number after loading file.
    +N               Alias for --line, if N is a number (eg.: +5).
    -m, --name NAME  The display name shown in Visual Studio Code.
    -t, --type TYPE  Treat file as having specified type.
    -n, --new        Open in a new window (Sublime Text).
    -f, --force      Open even if file is not writable.
    -v, --verbose    Verbose logging messages.
    -h, --help       Display this usage information.
        --version    Show version and exit.


### Default parameter configuration

Some default parameters (_host_ and _port_) can be configured by defining them
as the environment variables `RCODE_HOST` and `RCODE_PORT` or by putting them
in a configuration file. The configuration files loaded are `/etc/rcode.rc`
and `~/.rcode.rc`, e.g.:

    host: auto  # prefer host from SSH_CONNECTION over localhost
    port: 52698

Alternative notation for configuration file is:

    host=auto
    port=52698

The precedence for setting the configuration is (higher precedence counts):

1. default (localhost, 52698)
2. /etc/rcode.rc
3. ~/.rcode/rcode.rc
4. ~/.rcode.rc
5. environment variables (RCODE\_HOST, RCODE\_PORT)

## Disclaimer

Use with caution. This software may contain serious bugs. I can not be made responsible for
any damage the software may cause to your system or files.

## License

rcode

Copyright (C) 2011-2018 by Prodipta Guha <prodiptaguha95@gmail.com>

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
