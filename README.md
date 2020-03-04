# Ultimatate - Scrapper-Mailer-TwitterBot


Ultimate is a scraper, mailer, twitter bot solution created for CEO who need occupational activities (cause you know CEO don't do much :smirk:) :

- Open a folder
- Run your app
- Watch the magic happen

But let's start over and take it step by step

## Getting Started

[Not a scraping ninja](https://giphy.com/gifs/cheezburger-baby-ninja-flip-ErdfMetILIMko) but more of a [grumpy panda](https://media.giphy.com/media/ToMjGpIYtgvMP38WTFC/giphy.gif) ?

For you the Internet is just what you use for online-dating and ordering pizzas ?

Just listen to our lovely japanese anime like voice ([nani??](https://gph.is/2eJsE9X))


### Installation

As you can see on our lovely repository, two folders appear before your eyes.

We use *lib* and *app* if you want to navigate the code of each of our apps individualy. The *db* file will give you satisfaction if you are the reader type (like my grandma)

Your really really want to know how the repository is organized? Just relax and wait for the **tree** part.

If your goal is only to befriend all your representatives, then only focus on the root of the repository.

Make sure to ignore the .gitignore file (or don't but be ready to face our mighty heroes)

Open your terminal and :

```sh
$ bundle install
```

You should be ready to Gandalf the fuck out of your felloship.

"How do I do that" I hear ? Simply run the *app.rb* and [tadaaa](http://gph.is/2c9USIR)

### Tree

**(Please don't use each file one by one it won't be efficient. Just run *app.rb*)**

```
├── app.rb
├── db
│   └── townhalls.JSON
├── Gemfile
├── Gemfile.lock
├── lib
│   ├── app
│   │   ├── townhalls_follower.rb
│   │   ├── townhalls_mailer.rb
│   │   └── townhalls_scrapper.rb
│   └── views
└── README.md
```

townhalls_scrapper : *(scraps all the emails of the area you like, just modify them there)*

townhalls_mailer : *(using the scraper, spam the townhalls)*

townhalls_follower : *(mailing was not enough? go on twitter then. Follow, like at will)*

### Contributing

Contributors of the project?
  - Ludovic Ploton Luthor (Loundness)
  - Alexys Meunier (Alxys)
  - Willy Garcia (willyGitHub18)


# The End

Don't like the README ?
Please : <a href="https://www.youtube.com/watch?v=qdL5gMETIps">click</a>
