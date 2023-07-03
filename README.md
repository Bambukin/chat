# Anonymous chat
___
You can see an app example [here](https://rails-zb7j.onrender.com "here").

It's a simple application for communication with anonymous chat rooms.

When you're online you get a random name. You can create rooms, invite people there and chat.


It's an application that's been made to learn to use Action Cable.

```
Ruby version - 3.2.1
Rails version - 7.0.5
```

Before running start __redis__ server.
Execute the following line in the console to run the program:

```
bundle install

rails db:migrate

bin/dev
```

This App is set up to work on [Render](https://render.com "render") servers in production.
