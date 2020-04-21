# Putting a Laravel app into production

Tobias

May 23, 2018 · 8 min read

[Putting a Laravel app into production - Tobias - Medium](https://medium.com/@tobiashn/putting-a-laravel-app-into-production-d847ac2a04ed)

When tinkering around with Laravel you usually won’t think about some practical considerations you should watch out for, when developing an application that will go live one day. I recently put a Laravel-written web application into production and I wish there was an article like this one that tells me about things I should do or use to make my life much easier.

Also — I’ve recently started a whole「Laravel in production」series. It starts off with an article about Laravel’s built-in rate limiting features and why you should consider putting the rate limiting on the edge of your web-server stack (e.g. at your load balancer).

3『

[Laravel Rate Limiting in Production - The Startup - Medium](https://medium.com/swlh/laravel-rate-limiting-in-production-926c4d581886)

[Tobias – Medium](https://medium.com/@tobiashn)

』

## 01. Continuous Integration & Deployment

You may have heard of those terms「Continuous Integration」and「Continuous Deployment」. Let me outline why this is going to speed up your deployment process up. When going live with your production-ready Laravel app you are (hopefully) utilising Laravel’s awesome testing functions to make sure everything works as expected. By writing unit and integration tests for your application you’ll raise your code’s quality and lower the risk of malfunctions or security leaks. So if you are not writing tests, yet — start right now.

### 1. Running your tests automatically

Continuous Integration (CI) will take your code when you push it to your version control system ( → e.g Git) and will execute all your tests in a pre-defined build environment to make sure everything is working as expected, not only on your development machine but also in a clear production-alike environment.

Example: Running unit tests on GitLab’s CI platform.

I’m using GitLab’s free and open source Community Edition to build up my own code management infrastructure. It features a completely configurable CI/CD platform including runners that execute your build tasks on demand.

When pushing my code into the master branch, GitLab automatically triggers the CI process. In my case GitLab is using a Docker container to set up an environment that exactly fits the needs of the Laravel application and executes all tests within it.

You may not only execute phpunit tests but also run every other toolchain on your code that may detect errors or unwanted behavior. When the GitLab runner detects any kind of failure it will cancel the test progress and report the results back to you.

### 2. Deployment

Laravel’s ecosystem provides a pretty useful tool called Envoy. You can easily composer require it into your project. All of its magic takes place in a Envoy.blade.php in your project root where you can define SSH-based tasks and command that shall be ran upon execution. So if you want to cache your routes after pulling the latest code changes from your code repository you can just add the corresponsing php artisan route:cache command into your Envoy runner file. When you execute envoy run \$taskName the specified task will be executed on your pre-defined servers via SSH and everything should be fine.

3『 [Envoy Task Runner - Laravel - The PHP Framework For Web Artisans](https://laravel.com/docs/5.6/envoy) 』

But: You may not want to manually execute this command each time there were changes in your code and you waited for the CI system to report that your latest push was fine. So I warmly recommend you to utilise the Continuous Deployment (CD) system of GitLab as well.

Example: Deploy your Laravel app using GitLab’s CD in just a few seconds.

There is a well written documentation how to automatically deploy your Laravel application into production using GitLab’s CI/CD I want to refer to at this point. But when I read it the first time I had a few struggles understanding what the Docker-part in this tutorial is doing in detail.

So here’s a short explaination how GitLab, Docker and Laravel’s Envoy are working together to put your code at your web server. When pushing new commits to GitLab, it will instruct a CI/CD runner to spin up a new Docker container that is defined by the Dockerfile in your project’s root. In here a PHP 7.1 basic image is used, some packages (like Git) are installed and composer is downloaded. So basically everything that Laravel requires is in there. You could now do anything you want with your Laravel application. In the first step phpunit and other toolchains are executed to test your latest code inside the Docker container. If this job is successful the Docker environment is teared down and will build up again when you trigger the production job. Again thanks to the Dockerfile there will be all packages present you’ll need to push your app into production using the Laravel Envoy Task Runner. It relies on PHP and on some basic Composer packages and will execute all commands you need to get the latest code on your server.

So basically Docker provides a neutral place to run your application’s tests and deployment scripts into an environment that provides every dependency that is required.

Here are some further practical considerations according to my experiences: 1) Make sure you execute all necessary artisan commands in your Envoy.blade.php (database migrations, caching, queue worker restart, etc.). 2) Double-check whether your deployment user has sufficient rights to write to your httpdocs directory at your web server. Many problems I had came from problems with the directory permissions. 3) Lock your application (put it into maintenance mode) if you are running database migrations to ensure that no database inconsistency occures.

## 02. Optimise your code

When developing locally you may not waste a thought on optimised code at first. And it practially won’t even matter in your local environment. But now think about the consequences when putting your application into production. Not only you but many users — maybe hundreds or thousands — will use your application. At the same time. Now you can just scale up your server infrastructure to handle all the concurrent requests or you could optimise your code to allow your code to be executed more often on less performant infrastructure. This could save you a lot of money.

### 1. Reduce database queries

Queries are putting a lot of load on your database servers. First step to optimise your code would be to simply reduce the amount of database queries your application executes. Grab yourself the Laravel Debugbar (One of the most useful Laravel packages — developed by Barry vd. Heuvel) and check your data intensive pages for the amount of queries. You will probably be suprised how many similar queries are actually executed more than once. There are a many ways to minify this amount of queries down to one or two. I won’t spend time on explaining the exact process of doing so when there’s already an outstanding video tutorial about exactly this thematic by Laracasts. Make sure to check it out.

3『

[barryvdh/laravel-debugbar: Laravel Debugbar (Integrates PHP Debug Bar)](https://github.com/barryvdh/laravel-debugbar)

[Let's Build A Forum with Laravel and TDD: From 56 Queries Down to 2](https://laracasts.com/series/lets-build-a-forum-with-laravel/episodes/20)

[Laracasts](https://laracasts.com/)

』

### 2. Use caching

You also should consider the applicability of caching in your Laravel application. If you are developing a forum application where users can post threads in specific pre-defined channels you won’t need to fetch the channels out of database on every single page view. Just load it once and store it in Redis or Memcached until the administrator adds new ones. It’s so easy with Laravel and will save you a lot of queries and database server load.

### 3. Use Laravel’s built-in code optimizers

Laravel provides a few artisan code-optimizing commands you should use. Just put them into your Envoy.blade.php to make sure they are executed every time you are putting a new version of your application on your production servers.

Route Caching: php artisan route:cache

Config Caching: php artisan config:cache

Composer Autoloader Optimisation: composer install --optimize-autoloader

## 03. Queues

Sometimes I have the feeling that queue-able Jobs and Notifications are the most underrated features in Laravel. But in fact they are pretty awesome. Think about the following situation: Your customer is placing an order at your Laravel-based web shop and clicked on the「Buy now」button. What is your application going to do? Probably a hell of things, like for example: 1） Sending a confirmation e-mail to the customer. 2) Sending a notification to your Slack channel. 3) Adding the order to the database. (and much more)

But while you are doing all this, your user expects to be redirected to a「Order has been placed」-page. Now think about the worst case: The page is loading and loading as there are problems with your e-mail server and after lots of waiting your customer gets a HTTP Error 500 due to a TimeoutException of the mailer class in your application. This would be pretty bad for your shop’s reputation. But even if you look at the normal case where it would take a few seconds to get connected to your SMTP server or to the Slack API your user is waiting those seconds.

Laravel’s queue system is designed to get a response to the user as quick as possible and let background workers do the time intensive stuff. And on top Laravel’s Horizon, which is an official open source add-on package for your Laravel app, gives you insight view at your queues and successful and failed jobs.

3『 [Laravel Horizon - Laravel - The PHP Framework For Web Artisans](https://laravel.com/docs/5.6/horizon) 』

Keep track of your queues and jobs in Laravel Horizon’s handy metrics dashboard.

So when something’s wrong with your queues you can directly check for the exceptions that have been thrown by your implementation. No time is wasted and your user won’t see that there is some trouble ongoing behind the scenes. Some e-mails may be delayed but for the user everything is loading rapidly as usual. So definitely make use of those awesome Queueables.

## 04. Logging

One last short pointer for you: Shit happens. But when it does, make sure that it will be logged and you can reproduce the error to work on it. Turn on logging, log relevant events and exceptions and check back on errors. And don’t display technical stuff to the user. Users usually don’t want to see stuff like this and sometimes even sensitive information may be leaked.

## Conclusion

These were my experiences and tipps I wanted to share with you regarding the task of putting a Laravel application into production. Here is the summary for the busy readers:

Use Version Control (e.g. Git) and CI/CD (e.g. GitLab & Docker) for automated testing and deployment.

Make use of Laravel’s Envoy when it comes to SSH-based tasks that need to be executed in order to get your application running on your live servers.

Reduce database queries and use caching where applicable.

Execute Laravel’s and Composer’s built-in optimisation commands.

Use queues whenever it would take too long to send a respond to your user or if you want to keep track of failed/successful jobs out of the box.

Enable logging and have a look at the log files.

Thank you for reading and make sure to check out my other articles that are about real-life tips about Laravel apps in production. The most recent article is about rate-limiting in the Laravel middleware vs. rate-limiting at your load balancer.
