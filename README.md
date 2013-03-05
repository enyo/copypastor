# CopyPastor

*Version 0.0.1*

The easiest way to paste code.

Pasting some code and sharing it with coworkers is something needed at a daily
basis and has to be as fast and efficient as possible.

That's why services like pastebin.com and pastee.org are great, but when it
comes down to it: they are too slow.

You can use CopyPastor on copypastor.com, but the main purpose is for you to
**install it on a local server** so it's as fast as possible.


## Requirements

You need

- [node](http://nodejs.org) to run the app
- [mongodb](http://www.mongodb.org) to store the pastes
- [redis](http://redis.io) to handle the sessions

Once that's done, simply check out the service:

```bash
$ git clone https://github.com/enyo/copypastor.git
```

optionally update the dependencies

```bash
$ npm update
```

copy the default config file to the local file and remove the settings you
want to keep, and change those you want changed:

```bash
$ cp config/default.yaml config/local.yaml
```

and launch the server

```bash
$ ./server
```