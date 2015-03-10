# hubot-glink

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


For comma delimited configs be sure to use a space after the comma (i.e.
`value, other`) as the parsing isn't very forgiving and this will allow you to
use things like graphite value lists (i.e. `{foo,bar}`) in your configs without
them being parsed as individual items.


## License and Copyright

MIT License

(c) 2015 Jason Madsen
