# The build script

This is a very simple build script that puts together the YAML + JADE page files
and the pure JADE template files. It also builds the blog index.

Load modules

    fs = require 'fs'
    mkdirp = require('mkdirp').sync;
    jade = require 'jade'
    yaml = require 'js-yaml'
    config = require './config'

### Markdown

Add custom markdown parser
with custom code parsing function
that highlights with Pygments

**note**: We are overriding `renderer.code`
instead of `renderer.options.highlight`
because it wraps the highlihter result in unnecessary `<pre><code>`.

**note**: Since Jade doesn't support async filters,
we have to use `child_process.execSync`.
This requires Node >= 0.11.12

Further reading:
- [Marked overriding-renderer-methods](https://www.npmjs.com/package/marked#overriding-renderer-methods)
- [Node child_process.execSync](http://nodejs.org/docs/v0.12.0/api/child_process.html#child_process_child_process_execsync_command_options)
- [Jade How to define/install custom filter?](https://github.com/jadejs/jade/issues/1055)
- [Pygments lexers](http://pygments.org/docs/lexers/)

    execSync = (require 'child_process').execSync
    marked = require 'marked'

    renderer = new marked.Renderer
    renderer.code = (code, lexer = 'text') ->
        result = execSync "pygmentize -l #{lexer} -f html",
            input: code
        return result.toString()

    marked.setOptions
        renderer: renderer

    jade.filters.markdown = marked

### Template loader

Templates are different from pages in that they don't have a YAML front matter.
They are written in clean jade and can extend and include other templates.

    class Template
        constructor: (@name = 'page', @location = config.templatesPath) ->
        getHtml: (options) ->
            cwd = process.cwd()
            options.pretty = config.pretty
            options.filename = @name
            try
                process.chdir @location
                content = fs.readFileSync "#{@name}.jade", 'utf8'
                @html = jade.render content, options
            catch error
                console.log error
            finally
                process.chdir cwd
            return @html

## Page loader

    class Page

A nice /regexp?/ from the
[dworthen/js-yaml-front-matter](https://github.com/dworthen/js-yaml-front-matter/blob/master/lib/js-yaml-front.js)
repo to separate the YAML front matter from the JADE page content.

        re: /^(-{3}(?:\n|\r)([\w\W]+?)(?:\n|\r)-{3})?([\w\W]*)*/

Set the file name and location

        constructor: (@pageFile, @location = config.pagesPath) ->

Render the HTML

        render: ->

Make sure we have content

            if not @content?
                if not @pageFile?
                    throw new Error 'pageFile not set'
                location = "#{@location}/#{@pageFile}"
                @content = fs.readFileSync location, 'utf8'

Parse the content

            parts = @re.exec @content
            if ! @frontMatter?
                @frontMatter = if parts[2]? then yaml.safeLoad parts[2] else {}
            this[key] = value for key, value of @frontMatter
            if ! @containerContent?
                @containerContent = jade.render parts[3] or '',
                    filename: @pageFile
                    pretty: config.pretty

Parse the template

            template = new Template @template or null
            @html = template.getHtml this

Write the page into the output directory. I might move this to a separate
function (class) later on maybe?

        write: ->
            folder = "#{config.htmlPath}#{@url}"
            mkdirp folder unless fs.existsSync folder
            fs.writeFileSync "#{folder}/index.html", @html

#### Blog

It's the blog index page.

    class Blog extends Page
        posts: []
        content: ''
        template: 'blog'
        title: 'Blog'
        url: '/blog'

#### Pages

Iterate through a given directory and process the given pages.

Each page is pushed into a list of pages that will later be used for blog building
and sitemap.xml

    class Pages
        constructor: (@location) ->
            @pages = []
        render: ->
            for pageFile in (fs.readdirSync @location).reverse()
                page = new Page pageFile, @location
                page.render()
                page.write()
                @pages.push page

#### Blogs

Do the Pages thing and build a blog index on top.

    class Blogs extends Pages
        render: ->
            super()
            blog = new Blog
            blog.posts = @pages
            do blog.render
            do blog.write

# Render

    pages = new Pages config.pagesPath
    pages.render()
    blogs = new Blogs config.blogPath
    blogs.render()
