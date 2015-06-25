## V 0.1.0

Added multi app support. This release removes the following ENV vars:

* `HUBOT_GLINK_TEMPLATE`
* `HUBOT_GLINK_TEMPLATE_DEFAULTS`

And adds the following ENV vars

* `HUBOT_GLINK_DEFAULT_APP` - the name of the app to use when no app is specified
* `HUBOT_GLINK_<appname>_TEMPLATE` - where <appname> replaced by your application name
* `HUBOT_GLINK_<appname>_TEMPLATE_DEFAULTS` - where <appname> is replaced by your application name

This will allow for configuring of multiple applications by adding more of the TEMPLATE and TEMPLATE_DEFAULT environment variables.

