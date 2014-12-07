# TodoistizeMail
[![wercker status](https://app.wercker.com/status/74b012101b9ef41001e3b4c96691fc65/m "wercker status")](https://app.wercker.com/project/bykey/74b012101b9ef41001e3b4c96691fc65)

todoistize-mail is allow you to integrate your mail into todoist.(required IMAP.)

## Installation

```ruby
gem 'todoistize-mail'
```

### setup
```
tize setup
```

Then start interactive setup.(make `~/.todoistize.yml`)

## Usage
You type `tize help` and you can look more information.

### show list tasks of todoist
```
tize tasks
```

### show list unread mails
```
tize unread
```

### import your unread mails into todoist
```
tize todoistize
```

### complete your task and mark read mail
```
tize done --task-id 11111
```

## Contributing

1. Fork it ( https://github.com/joe-re/todoistize-mail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
