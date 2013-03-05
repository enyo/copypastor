
config = require "config"

TextBlock = require "../models/text-block"

exports.index = (req, res) ->
  res.render "index", { site: "home" }


exports.newTextBlock = (req, res, next) ->
  return next new Error "No text submitted" unless req.body.text

  textBlock = new TextBlock text: req.body.text
  textBlock.name = req.body.name if req.body.name?

  textBlock.save (err) ->
    return next err if err?
    res.redirect "/#{textBlock._id}"


exports.list = (req, res, next) ->
  TextBlock.find({ }).sort("-_id").exec (err, textBlocks) ->
    return next err if err?
    res.render "list", { site: "list", textBlocks: textBlocks }


exports.textBlock = (req, res, next) ->
  TextBlock.findById req.params.id, (err, textBlock) ->
    return next err if err?
    return next "Invalid id #{req.params.id}" unless textBlock

    res.render "text-block", { site: "text-block", textBlock: textBlock, textBlockUrl: config.general.url.replace '#{id}', textBlock._id }
