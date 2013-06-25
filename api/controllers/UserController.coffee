###--------------------
    :: User 
        -> controller
--------------------###
UserController =
  index: (req, res) ->
    User.findAll().done (err, users) =>
      if err
        console.log err
        res.json users: users
        return
      return
module.exports = UserController;
