# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.paths << Rails.root.join('vendor', 'javascript')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'stylesheets')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'bootstrap')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'fontawesome-free')
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w[
  bootstrap.min.js
  bootstrap.bundle.min.js
  bootstrap.js
  popper.js
  application.scss
  @popperjs--core.js
  @rails--ujs.js
  jquery.js
  turbolinks.js
  bootstrap-icons.woff
  bootstrap-icons.woff2
  bootstrap-icons.css
  sb-admin-2.css
  sb-admin-2.min.css
  sb-admin-2.js
  highcharts.js
]
Rails.application.config.assets.precompile << 'bootstrap.min.js'
Rails.application.config.assets.precompile << 'sb-admin-2.js'
