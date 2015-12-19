# Mocha Retry

This is the repo for Mocha Retry project.

## Documentation

This Mocha plugin allows you to run a test and, if it fails, rerun it a number of times.

### Why you shouldn't use this

Tests that pass sometimes, and sometimes they don't are a bad smell. Your tests should be consistent: either they always pass, or they always fail.
So, don't you this Mocha plugin, instead make your tests consistent.

### Why you maybe want to use this

The above rule should be followed always, but sometimes you can't.
Some tests are inherently incosistent, like tests that touch some type of physical artifact, like the network, files, or a web browser.
Such tests may fail for reasons outside of your control. Maybe the network had a hiccup, or your web browser driver failed to communicate properly with the web browser.
Who knows? If you can trace the problem and eliminate, then do that, it is the preferred option. If you can't, then you have this Mocha plugin.

## Why I wrote this

The main problem I have is with end to end tests driving a web browser. I use mostly Selenium WebDriver and I have developed lots of techniques that help me work around
most of the issues caused by the inherent instability of such tests, but some are just not easily fixable. This is the problem I am solving for myself.

### Using it

You can specify the retry count on the test directly like this:

```coffeescript
it 2, 'a test', ->
  #your test goes here, it will be retried at most twice
```

Or you can specify the retry count on the suite, like this:

```coffeescript
describe 4, 'some suite', ->
  it 'a test', ->
    #your test goes here, it will be retried at most twice
```

If you specify both the test has precedence. This test will be retried at most twice, not 4 times:

```coffeescript
describe 4, 'some suite', ->
  it 2, 'a test', ->
    #your test goes here, it will be retried at most twice
```

You can still use the default `it` behaviour, without retry, just do not specify a retry as you normally would on a Mocha test.

## Installing via npm

Just run on your terminal:

```
npm install mocha-retry
```

Then you will have to change the ui, use `xunit-retry` as your ui. See the example [here](https://github.com/giggio/mocha-retry/blob/master/test/mocha.opts) on the mocha.opts file.

### Problems running it with a locally installed package

Mocha is not yet able to use a locally installed ui. I have submitted a [pull request](https://github.com/visionmedia/mocha/pull/1240) to fix that.
Until then either use my version of mocha from which I did the pull request or install it globally.

## Issues

* You can check the [Github issues](https://github.com/giggio/mocha-retry/issues) directly.

## Maintainers

* [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/), [Lambda3](http://www.lambda3.com.br), [@giovannibassi](http://twitter.com/giovannibassi)

## License

This software is open source, [licensed at Apache 2.0](https://github.com/giggio/mocha-retry/blob/master/LICENSE.txt). Check out the terms of the license before you contribute, fork, copy or do anything
with the code. If you decide to contribute you agree to grant copyright of all your contribution to this project, and agree to
mention clearly if do not agree to these terms. Your work will be licensed with the project at Apache 2.0, along the rest of the code.
