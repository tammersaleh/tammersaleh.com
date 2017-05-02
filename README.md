# tammersaleh.com

This is my home.  Please keep it clean.

Feel free to submit pull requests.

## Running

Using Docker:

```
$ docker build -t tammersaleh.com .
$ docker run -it -v $(pwd):/app -p 4567:4567 tammersaleh.com
$ open http://localhost:4567/
```

Without Docker:

```
$ bundle install
$ middleman server
$ open http://localhost:4567
```

## Deploying

This site is [auto-deployed to S3 by Travis CI](https://travis-ci.org/tsaleh/tammersaleh.com) on every push.  See the [.travis.yml](https://github.com/tsaleh/tammersaleh.com/blob/master/.travis.yml) file for details.

Once you've deployed, you can use [Sizzy.co](http://sizzy.co) to [check the responsiveness](http://sizzy.co/?url=http%3A%2F%2Ftammersaleh.com).
