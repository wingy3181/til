# How to Write an Open Source JavaScript Library

## Overview

- Introduction to How to Write an Open Source JavaScript Library
- Setting up GitHub
- Configuring npm and creating a package.json
  - Use `.npmrc` with [npm configurations](https://docs.npmjs.com/misc/config) to default some options
- Creating the library and adding dependencies
- Pushing to GitHub
- Publishing to npm - `https://www.npmjs.com/package/<package> | https://npm.im/<package>`
  - `npm publish`
  - `npm info <package>`
- Releasing a version to GitHub
  - `git tag x.y.z && git push --tags`
  - GitHub release tab
- Releasing a new version to npm
  - Make changes and update version according to semantic versioning; `x.y.z`
    - `x` : Breaking changes
    - `y` : New functionality
    - `z` : Bug fixes
  - Re-`git tag`, re-`git push` and re-`npm publish`
  - **NOTE: This can now be done with the one command [`npm version [major|minor|patch]`](https://docs.npmjs.com/cli/version)**
- Publishing a beta version
  - Use a semver of `x.y.z-beta.0`
  - To use beta version can install via `npm install <package>@beta` (or use the exact version of course)
- Setting up Unit Testing with Mocha and Chai
  - `npm install -D mocha chai`
  - `describe` and `it` global functions from Mocha
  - `expect` assertions from Chai
  - Run `mocha` in watch mode with `-w` flag and add as npm script
- Unit Testing with [Mocha](https://mochajs.org/) and [Chai](http://chaijs.com/)
- Automating Releases with [semantic-release](https://github.com/semantic-release/semantic-release)
  - `npm install -g semantic-release-cli`
  - `semantic-release-cli setup`
    - Integrates with TravisCI and adds a `.travis.yml`
  - This will update `package.json`
    - `semantic-release` npm script
    - Should add a package.json version to `0.0.0-semantically-released` to avoid npm warnings
  - Based on git message conventions it will update the version accordingly. By default, uses [AngularJS Git Commit Message Conventions](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md#-git-commit-guidelines) but this can be [customised](https://github.com/semantic-release/semantic-release#plugins)
- Writing conventional commits with [commitizen](https://github.com/commitizen/cz-cli)
  - `npm i -D commitizen cz-conventional-changelog`
  - Add npm script: `commit`: `git-cz` and  add configuration to package.json (or `.czrc`) to use `cz-conventional-changelog`
  - Add to travis a step for build to run `npm run test`
  - Can add `closes #x` to footer to close issues within GitHub
- Committing a new feature with commitizen
  - `npm run commit`
- Automatically releasing with TravisCI
  - Because of the use of `semantic-release` and `commitizen` the following is automated:
    - CI to build and test code via TravisCI
    - If successful, automatic `npm publish` and version updates depending on commit conventions enforced by `commitizen`
- Automatically running tests before commits with ghooks
  - [`ghooks`](https://github.com/gtramontina/ghooks) is now deprecated in favor of [`husky`](https://github.com/typicode/husky)
  - Sets up git hooks that will be available to all contributors as these hooks are normally in `.git/hooks` folder which is excluded from being committed by git
  - Add git hook script to npm scripts with specific [hook](https://github.com/typicode/husky/blob/master/HOOKS.md) keywords. For example:
  ```Javascript
  // Edit package.json
  {
    "scripts": {
      "precommit": "npm test",
      "prepush": "npm test",
      "...": "..."
    }
  }
  ```  
- Adding code coverage recording with Istanbul
  - `npm i -D istanbul`
  - Instrument tests with istanbul by changing test script with `istanbul cover -x *.test.js _mocha -- spec src/index.test.js`
    - `-x` excludes certain files from coverage report
    - Use `_mocha` instead of `mocha` binary because the executable without an underscore forks processes to run your tests, but istanbul needs the tests in the same process. Other test framework usage may vary.
    - `--` tells istanbul to pass following arguments to the test process rather than consume them itself
    - `spec` is the [reporter](https://mochajs.org/#reporters) (`-R` or `--reporter`)
  - Generates coverage information in `.coverage/`
- Adding code coverage checking
  - Add npm script: `check-coverage` to run `istanbul check-coverage <xxx> --statements --branches <xxx> --functions <xxx> --lines <xxx>`
  - Change travis and ghooks pre-commit to run `check-coverage`
- Add code coverage reporting
  - Use <http://codecov.io>
  - `npm i -D codecov.io`
  - Add npm script: `report-coverage` to run `cat ./coverage/lcov.info | codecov`
  - Add to travis to run `report-coverage` after build success
- Adding badges to your README
  - Use <https://sheld.io>
- Adding ES6 Support
  - `npm i -D babel-cli` so babel is available
  - `npm i -D babel-preset-es2015 babel-preset-stage-2` so babel transformations are available and configure either via `package.json` or `.babel.rc`
  - Add npm script to build and transpile src (ES6) to dist (ES5): `babel --copy-files --out-dir dist --ignore *.test.js src`
    - `--copy-files` so non-js files also get coppied to dist
    - `--out-dir` is the output directory
    - `--ignore` is the files to ignore for transpiling
  - Use `rimraf` to clean dist folder (cross platform) in `prebuild` phase
  - `npm pack` to get packaged version of module to check distributed files.
    - can use `files` keyword in `package.json` to limit files in package
- Adding ES6 Support to Tests using Mocha and Babel
  - Use `nyc` instead of `istanbal` and `babel-register`
- Limit Built Branches on Travis
  - Add branches config to `.travis.yml`
- Add a browser build to an npm module
  - `umd` library target (Universal module definition)
  - Uses webpack to make library compatible with browser
  - Should exclude transitive dependencies if they are large using webpack
  - Can use in website via CDN: <https://unpkg.com/#/>

> References
> * 👍 [Egghead.io - How to Write an Open Source JavaScript Library | 17 Jul 2016](https://egghead.io/courses/how-to-write-an-open-source-javascript-library)
>   * [Source | Kent C. Dodds - starwars-names](https://github.com/kentcdodds/starwars-names)
>   * [RunKit+npm - starwars-names](https://runkit.com/npm/starwars-names)
>   * [Slides | Kent C. Dodds](http://slides.com/kentcdodds/write-oss#/)
> * [Egghead.io - Get Started Contributing to JavaScript Open Source](https://egghead.io/articles/get-started-contributing-to-javascript-open-source)
