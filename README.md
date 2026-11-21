# Kanban prototype

[xet7](https://github.com/xet7) created this test fork
of this kanban prototype. It remains to be seen,
does this prototype get enough progress to be useful.
It's just at test, does xet7 get stuck somewhere.

A list of prototypes:

https://github.com/wekan/wekan/wiki/WeKan-Multiverse-Roadmap

xet7 also sent some updates upsteam:

https://github.com/jbigler/i-can-has-kanban/pull/4

## Fork of I Can Has Kanban

https://github.com/jbigler/i-can-has-kanban

*Yes, you can!*

Welcome to the meme Kanban board that jbigler created
as a learning project for the latest Rails stack.

After creating an account, you can create workspaces
which will be able to be shared with others.
Within a workspace you can create as many boards as you need.
Each board has a collection of lists, and each list has a collection of cards.
The boards and lists can be manipulated via drag-and-drop.
If you invite another User to your workspace, you can
both work on the same board together.
Turbo frames and streams are used to broadcast the changes.

## Some notes on the stack used
- Ruby 4.0.10
- Ruby on Rails 8.1.4.1
- [Authentication Zero](https://github.com/lazaronixon/authentication-zero)
- SQLite, with [Solid Cache](https://github.com/rails/solid_cache) and
  [Solid Cable](https://github.com/rails/solid_cable) in production
- Flowbite TailwindCSS components
- [SortableJS](https://github.com/SortableJS/Sortable) through Stimulus
- Turbo frames and streams
- Pundit
- Minitest
- FactoryBot
