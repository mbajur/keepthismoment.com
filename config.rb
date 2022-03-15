# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :blog do |blog|
  blog.prefix = 'posts'
  blog.permalink = "{year}-{month}-{day}-{title}.html"
end

activate :directory_indexes

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def band(name, &block)
    content = capture_html(&block)

    concat_content(
      <<-HTML
        <div class="band">
          <div class="band-name code f6">#{name}</div>

          <div class="mw8-ns center pa3 ph5-ns main-content">
            #{content}
          </div>
        </div>
      HTML
    )
  end

  def photo(filename, wide: false)
    filename = filename.include?('.') ? filename : "#{filename}.jpg"

    <<-HTML
      <div class="photo #{'photo--wide' if wide}">
        <img src="https://keepthismoment.s3.amazonaws.com/2020.02.07.wide.smiles.11/#{filename}.jpg" width="mw-100"/>
      </div>
    HTML
  end

  def gallery(wide: false, &block)
    content = capture_html(&block)

    concat_content(
      <<-HTML
        <div class="gallery #{'gallery--wide' if wide}">
          #{content}
        </div>
      HTML
    )
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
