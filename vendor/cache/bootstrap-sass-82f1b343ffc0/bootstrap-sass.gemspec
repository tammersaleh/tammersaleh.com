# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bootstrap-sass"
  s.version = "3.0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thomas McDonald"]
  s.date = "2013-09-28"
  s.email = "tom@conceptcoding.co.uk"
  s.files = [".gitignore", ".travis.yml", "CHANGELOG.md", "CONTRIBUTING.md", "Gemfile", "LICENSE", "README.md", "Rakefile", "bootstrap-sass.gemspec", "docs/COMPASS.md", "docs/RAILS.md", "lib/bootstrap-sass.rb", "lib/bootstrap-sass/compass_functions.rb", "lib/bootstrap-sass/engine.rb", "lib/bootstrap-sass/sass_functions.rb", "lib/bootstrap-sass/version.rb", "tasks/converter.rb", "templates/project/manifest.rb", "templates/project/styles.scss", "test/compilation_test.rb", "test/gemfiles/sass_3_2.gemfile", "test/gemfiles/sass_head.gemfile", "test/test_helper.rb", "vendor/assets/fonts/bootstrap/glyphicons-halflings-regular.eot", "vendor/assets/fonts/bootstrap/glyphicons-halflings-regular.svg", "vendor/assets/fonts/bootstrap/glyphicons-halflings-regular.ttf", "vendor/assets/fonts/bootstrap/glyphicons-halflings-regular.woff", "vendor/assets/javascripts/bootstrap.js", "vendor/assets/javascripts/bootstrap/affix.js", "vendor/assets/javascripts/bootstrap/alert.js", "vendor/assets/javascripts/bootstrap/button.js", "vendor/assets/javascripts/bootstrap/carousel.js", "vendor/assets/javascripts/bootstrap/collapse.js", "vendor/assets/javascripts/bootstrap/dropdown.js", "vendor/assets/javascripts/bootstrap/modal.js", "vendor/assets/javascripts/bootstrap/popover.js", "vendor/assets/javascripts/bootstrap/scrollspy.js", "vendor/assets/javascripts/bootstrap/tab.js", "vendor/assets/javascripts/bootstrap/tooltip.js", "vendor/assets/javascripts/bootstrap/transition.js", "vendor/assets/stylesheets/bootstrap.scss", "vendor/assets/stylesheets/bootstrap/_alerts.scss", "vendor/assets/stylesheets/bootstrap/_badges.scss", "vendor/assets/stylesheets/bootstrap/_breadcrumbs.scss", "vendor/assets/stylesheets/bootstrap/_button-groups.scss", "vendor/assets/stylesheets/bootstrap/_buttons.scss", "vendor/assets/stylesheets/bootstrap/_carousel.scss", "vendor/assets/stylesheets/bootstrap/_close.scss", "vendor/assets/stylesheets/bootstrap/_code.scss", "vendor/assets/stylesheets/bootstrap/_component-animations.scss", "vendor/assets/stylesheets/bootstrap/_dropdowns.scss", "vendor/assets/stylesheets/bootstrap/_forms.scss", "vendor/assets/stylesheets/bootstrap/_glyphicons.scss", "vendor/assets/stylesheets/bootstrap/_grid.scss", "vendor/assets/stylesheets/bootstrap/_input-groups.scss", "vendor/assets/stylesheets/bootstrap/_jumbotron.scss", "vendor/assets/stylesheets/bootstrap/_labels.scss", "vendor/assets/stylesheets/bootstrap/_list-group.scss", "vendor/assets/stylesheets/bootstrap/_media.scss", "vendor/assets/stylesheets/bootstrap/_mixins.scss", "vendor/assets/stylesheets/bootstrap/_modals.scss", "vendor/assets/stylesheets/bootstrap/_navbar.scss", "vendor/assets/stylesheets/bootstrap/_navs.scss", "vendor/assets/stylesheets/bootstrap/_normalize.scss", "vendor/assets/stylesheets/bootstrap/_pager.scss", "vendor/assets/stylesheets/bootstrap/_pagination.scss", "vendor/assets/stylesheets/bootstrap/_panels.scss", "vendor/assets/stylesheets/bootstrap/_popovers.scss", "vendor/assets/stylesheets/bootstrap/_print.scss", "vendor/assets/stylesheets/bootstrap/_progress-bars.scss", "vendor/assets/stylesheets/bootstrap/_responsive-utilities.scss", "vendor/assets/stylesheets/bootstrap/_scaffolding.scss", "vendor/assets/stylesheets/bootstrap/_tables.scss", "vendor/assets/stylesheets/bootstrap/_theme.scss", "vendor/assets/stylesheets/bootstrap/_thumbnails.scss", "vendor/assets/stylesheets/bootstrap/_tooltip.scss", "vendor/assets/stylesheets/bootstrap/_type.scss", "vendor/assets/stylesheets/bootstrap/_utilities.scss", "vendor/assets/stylesheets/bootstrap/_variables.scss", "vendor/assets/stylesheets/bootstrap/_wells.scss", "vendor/assets/stylesheets/bootstrap/bootstrap.scss"]
  s.homepage = "http://github.com/thomas-mcdonald/bootstrap-sass"
  s.licenses = ["Apache 2.0"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Twitter's Bootstrap, converted to Sass and ready to drop into Rails or Compass"
  s.test_files = ["test/compilation_test.rb", "test/gemfiles/sass_3_2.gemfile", "test/gemfiles/sass_head.gemfile", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<compass>, [">= 0"])
      s.add_development_dependency(%q<term-ansicolor>, [">= 0"])
      s.add_development_dependency(%q<sass-rails>, [">= 3.2"])
      s.add_runtime_dependency(%q<sass>, ["~> 3.2"])
    else
      s.add_dependency(%q<compass>, [">= 0"])
      s.add_dependency(%q<term-ansicolor>, [">= 0"])
      s.add_dependency(%q<sass-rails>, [">= 3.2"])
      s.add_dependency(%q<sass>, ["~> 3.2"])
    end
  else
    s.add_dependency(%q<compass>, [">= 0"])
    s.add_dependency(%q<term-ansicolor>, [">= 0"])
    s.add_dependency(%q<sass-rails>, [">= 3.2"])
    s.add_dependency(%q<sass>, ["~> 3.2"])
  end
end
