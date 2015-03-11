class Namespacer
  constructor: (prefix) ->
    @prefix = prefix

  prepend: (value) ->
    @prefix + value

  clear: (value) ->
    if @inNS(value)
      value.slice(@prefix.length)
    else
      value

  inNS: (value) ->
    value.indexOf(@prefix) == 0

module.exports = Namespacer
