# Jumpstarter

**Version 0.0.3**

Start multiple node clusters easily.


## Usage


```js
var jumpstarter = require("jumpstarter");

jumpstarter.createWorkers(function(done) {
  /* Startup your application here, for example: */
  var express = require("express");
  var app = express();
  // etc...

  var port = 3000;
  app.listen(port);

  /* Now tell jumpstarter that it's started properly */
  done({ port: port, mode: app.settings.env });
  
});
```
