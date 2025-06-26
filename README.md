# Flame Engine Site

<p align="center">
  <a title="Deploy" href="https://github.com/flame-engine/flame-engine-site/actions?query=workflow%3Agh-pages+branch%3Amain"><img src="https://github.com/flame-engine/flame-engine-site/workflows/gh-pages/badge.svg?branch=main&event=push"/></a>
  <a title="Discord" href="https://discord.gg/pxrBmy4"><img src="https://img.shields.io/discord/509714518008528896.svg"/></a>
</p>

This is the main landing page of the Flame Engine website; it is deployed [here](https://flame-engine.org) via GitHub Pages.

This was built using [Jekyll](https://jekyllrb.com/)! Please send them some 💙 from us.

## Where do things come from?

We also have some special subdomains; they are deployed independently via other repos.

* docs.flame-engine.com is deployed from [flame-docs-site](https://github.com/flame-engine/flame-docs-site)
* examples.flame-engine.com is deployed from [flame](https://github.com/flame-engine/flame)

## Running locally

To run locally, you must first install node, npm, Ruby (we recommend RVM), ruby-gems, and the bundler.

Then, run:

```bash
npm install
bundle install
```

To download all the dependencies.

Then, run:

```bash
bundle exec jekyll serve
```

To start the local server.
