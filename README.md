# I Can Has Kanban?
*Yes, you can!*

![CI/CD](https://github.com/jbigler/i-can-has-kanban/actions/workflows/on_push.yml/badge.svg)

Welcome to the meme Kanban board that I created as a learning project for the latest Rails stack.

The project is deployed on a free fly.io instance at http://has-kanban.fly.dev

After creating an account, you can create workspaces which will be able to be shared with others.
Within a workspace you can create as many boards as you need.
Each board has a collection of lists, and each list has a collection of cards.
The boards and lists can be manipulated via drag-and-drop.
If you invite another User to your workspace, you can both work on the same board together.
Turbo frames and streams are used to broadcast the changes.

## Some notes on the stack used
- Ruby 3.2.5
- Ruby on Rails 7.2.1.1
- [Authentication Zero](https://github.com/lazaronixon/authentication-zero)
- [LiteStack](https://github.com/oldmoe/litestack)
- Flowbite TailwindCSS components
- [SortableJS](https://github.com/SortableJS/Sortable) through Stimulus
- Turbo frames and streams
- Pundit
- Minitest
- FactoryBot
