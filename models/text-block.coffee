
mongoose = require "mongoose"
ObjectId = mongoose.Schema.ObjectId


TextBlock = new mongoose.Schema

  creator: ObjectId

  name: String
  language: String

  text: String


module.exports = mongoose.model "Text", TextBlock