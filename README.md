# hubot-glink

[![Build Status](https://travis-ci.org/knomedia/hubot-glink.svg?branch=master)](https://travis-ci.org/knomedia/hubot-glink)

A hubot script for building graphite links

See [`src/glink.coffee`](src/glink.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-glink --save`

Then add **hubot-glink** to your `external-scripts.json`:

```json
[
  "hubot-glink"
]
```

## Sample Interaction

```
user1> hubot graphme users index
hubot> http://graphite.example.com/render?target=some.configed.target.users.index&width=800&.png
```

## Aliases

hubot-glink allows for stored aliases. While you can set some defaults for your
bot via environment configuration variables, chances are members of your team
are going to want a few "custom" things that only apply to them. They can
simply create aliases with all the values they want and `run` those aliases
whenever they want.

```bash
user1> hubot alias ui as users index --from=-3months --bgcolor=black
hubot: created alias `ui` for `users index --from=-3months --bgcolor=black`
user1> hubot alias ui
hubot: `ui` = `users index --from=-3months --bgcolor=black`
user1> hubot aliases
hubot: Aliases:

`ui` = `users index --from=-3months --bgcolor=black`

user1> hubot run ui
hubot: https://graphite.example.net/render?from=-3months&bgcolor=black&target=foo.users.index&image=.png

# `hubot run ui` is now equivalent to running:
# `hubot graphme users index --from=-3months --bgcolor=black`
```

## Configuration

As graphite keys will vary from one project to another, you will need to
configure a few things to get hubot-glink going for your project in graphite.
The following environment variables should allow you configure hubot-glink for
your project (See the [glink project](https://github.com/knomedia/glink) for
more information as these configs map somewhat to the configuration of `glink`)


Config Var Name                        | Note
-------------------------------------  | ---------------------------------------------------
HUBOT_GLINK_TEMPLATE                   | i.e. `stats.timers.!!#controller#!!.!!#action#!!`
HUBOT_GLINK_TEMPLATE_DEFAULTS          | (comma delimited i.e. `!!#controller===users#!!, #!!action===index#!!`
HUBOT_GLINK_HOSTNAME                   |
HUBOT_GLINK_DEFAULT_PARAMS             | optional (comma delimited i.e.: `from:-1week, width:800`)
HUBOT_GLINK_PROTOCOL                   | optional
HUBOT_GLINK_PORT                       | optional
HUBOT_GLINK_TEMPLATE_DEFAULT_DELIMITER | optional (defaults to ===)
HUBOT_GLINK_USE_SLACK_API              | optional, prettier posts for Slack via the API
HUBOT_GLINK_SLACK_IMAGES               | optional (default false), attempt to pull images into Slack
HUBOT_GLINK_SLACK_COLOR                | optional (default #CCC), color for Slack API post


For comma delimited configs be sure to use a space after the comma (i.e.
`value, other`) as the parsing isn't very forgiving and this will allow you to
use things like graphite value lists (i.e. `{foo,bar}`) in your configs without
them being parsed as individual items.


## License and Copyright

MIT License

(c) 2015 Jason Madsen
