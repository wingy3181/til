# Website Performance Optimization and Critical Rendering Path


![Critical Rendering Path](https://cloud.githubusercontent.com/assets/1212576/23326004/fb7dc544-fb4d-11e6-9f7d-7daa94828e55.png)

**<u>How does browser go from consuming HTML, CSS and JS to rendering pixels on screen?</u>**

1. Process HTML markup and build the DOM tree.
> - By default, "Render" blocking (browser won't render until DOM is constructed)
> - *Bytes → characters → tokens → nodes → object model.*

  - The larger the HTML, the longer the parsing of HTML → DOM
  - Captures content, attributes and relationships of the HTML
  - Preload scanner will "speculative parse" the rest of the document and request any other external resources (JS, CSS, images) that are
    referenced so they can be downloaded in parallel.
  - Can incrementally construct DOM (and render it) if HTML is delivered incrementally (i.e. Think ajax that later on modifies DOM)
2. Process CSS markup and build the CSSOM tree.
  > - By default, "Render" blocking (browser won't render until CSSOM is constructed) and "Javascript Execution" blocking (browser won't execute JS until CSSOM is constructed)
  >   - If it wasn't "render" blocking, the browser would apply the wrong style occasionally as a CSS that is processed later may change existing styles that have been already rendered.
  >     Also, we would experience a **"Flash of Unstyled Content (FOUC)"** otherwise.
  >   - Media types/queries allow us to mark some CSS resource as non-render blocking (e.g. print styles)
  >   - The browser downloads all CSS resources, regardless of blocking or non-blocking behavior.
  > - *Bytes → characters → tokens → nodes → object model.*

  - The larger the CSS, the longer the parsing of CSS → CSSOM
  - The more general selector is easier to evaluate (as browser matches CSS selectors right to left and has less nodes to traverse in DOM tree to validate selector)
    (Although generally not the performance bottleneck)
  - Style rules cascade down from parent nodes in the CSSOM tree to descendant nodes
3. Javascript
  > - By default, "Parser" blocking (browser stops DOM parsing until JS file is executed (and downloaded if external))
  > - Executing our inline script blocks DOM construction, which also delays the initial render.
  > - Browser delays script execution and DOM construction until it has finished downloading and constructing the CSSOM.

  - Top vs Bottom?
    - Top: When having JavaScript events function on elements immediately is more important (so if you use a DOM Ready event to load everything, this is the wrong place)
    - Bottom: When loading the content is more important
  - The location of the script in the document is significant.
  - When the browser encounters a script tag, DOM construction pauses until the script finishes executing.
  - JavaScript can query and modify the DOM and the CSSOM.
  - JavaScript execution pauses until the CSSOM is ready.

4. Combine the DOM and CSSOM into a render tree.
  - Only visible elements/nodes exist in render tree (e.g. nodes with display: none, script tags, meta tags, etc. are not visible and do not exist in render tree)
5. Run layout (a.k.a. reflow) on the render tree to compute geometry of each node (i.e. it's box model - exact position and size)
  - Dependent on viewport and will re-run if window is resized or orientation is changed
  - Dependent on render tree:
    - The larger the render tree, the longer the layout will take
    - Changes to styles or content will also cause layout to re-run (try to batch/group these changes)
6. Paint (a.k.a. rasterize) the individual nodes to the screen.
  - More complicated CSS styles, longer it takes to paint (e.g. "cheap" solid color versus "expensive" drop shadow)
  - Dependent on render tree:
    - Changes to styles or content will also cause paint to re-run (browser will try to minimize paint where it can)


If DOM or CSSDOM are modified, need to repeat process in order to figure out which pixels need to re-render

**<u>How does optimize Critical Rendering Path?</u>**

> "Measure first, optimize second"

> *<u>3 Strategies</u>*
>
> 1. Minimize Bytes
>    - Minify, compress, cache (HTML, CSS, JS)
> 2. Reduce number of critical resources
>    - Minimize use of render blocking resources (CSS)
>      - Use media queries on <link> to unblock rendering
>      - Inline CSS
>    - Minimize use of parser blocking resources (JS)
>      - Defer Javascript execution (by only executing after window.onload event)
>      - Use async attribute on <script>
> 3. Shorten length of critical rendering path

1. DOM
  - Remove inline CSS/JS comments and HTML comments and minify HTML
  - Minify, compress and cache
2. CSS
  - Remove unused styles
  - Minify, compress and cache
  - Use more general specificity and less effects (if able to)
  - Use media types/queries (e.g. <link rel="stylesheet" href="style-print.css" media="print") to separate unnecessary styles from render blocking css
    - This also makes render blocking css smaller
  - Inline critical CSS (only if specific to a page as there will be a maintenance cost if used in multiple places)
3. JS
  - Minify, compress it, cache it
  - Inline critical (DOM and CSSOM modifying) JS (only if specific to a page as there will be a maintenance cost if used in multiple places)
  - Non-critical JS that don't modify DOM and CSSOM (e.g. Analytics) should not be parse DOM blocking and be blocked on CSSOM and therefore should be declared with "async" (or "defer" if it isn't critical even though modifies DOM/CSSOM)

> References
> * [Google Developers - Web Fundamentals - Critical Rendering Path](https://developers.google.com/web/fundamentals/performance/critical-rendering-path/)
> * [Google Page Speed - Rules](https://developers.google.com/speed/docs/insights/rules)
> * [Udemy - Website Performance Optimization](https://www.udacity.com/courses/ud884)
> * [Google Developers - Web Fundamentials - Github](https://github.com/google/WebFundamentals/tree/master/src/content/en/fundamentals/performance/critical-rendering-path/_code)
> * [Ryan Seddon: So how does the browser actually render a website | JSConf EU 2015](https://www.youtube.com/watch?v=SmE4OwHztCc)
> * [Understanding the critical rendering path, rendering pages in 1 second](https://medium.com/@luisvieira_gmr/understanding-the-critical-rendering-path-rendering-pages-in-1-second-735c6e45b47a#.un4z5jb9m)
> * [How Browsers Work: Behind the scenes of modern web browsers - The order of processing scripts and style sheets](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/#The_order_of_processing_scripts_and_style_sheets)
> * [Difference between async and defer attributes in script tags](http://javascript.tutorialhorizon.com/2015/08/11/script-async-defer-attribute/)
> * [Top or bottom of the page - Where should you load your javascript/](http://demianlabs.com/lab/post/top-or-bottom-of-the-page-where-should-you-load-your-javascript/)
