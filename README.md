#slack-semaphore-integration

###[Semaphore](http://semaphoreapp.com)
Semaphore is a fully managed, high performance testing and deployment solution for your company.

###[Slack](http://slack.com)
It’s real-time messaging, archiving and search for modern teams.


##How it works
Receive message with build status from semaphore in your slack channel

![](https://s3.amazonaws.com/github_things/slack_message.jpg)

##Configuration
Add Incoming WebHooks Integration https://subdomain.slack.com/services/new

Expand Instructions for creating Incoming WebHooks and get the token
![](https://s3.amazonaws.com/github_things/token.jpg)

Go to semaphore / project / settings / notifications / webhooks

Add this url and change params

`http://slack-semaphore-integration.herokuapp.com?token=`yourtoken`&channel=`yourchannel`&subdomain=`yourdomain

###Done, your integration should work


## Contributing

1. Fork it ( https://github.com/brunoadacosta/slack-semaphore-integration.git )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
