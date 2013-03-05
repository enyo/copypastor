
mongoose = require "mongoose"
ObjectId = mongoose.Schema.ObjectId


UserSchema = new mongoose.Schema

  username: String
  password: String


module.exports = mongoose.model "User", UserSchema