workflow "phpunit / phpinsights" {
  on = "push"
  resolves = [
    "phpunit",
    "phpinsights"
  ]
}

# Install composer dependencies
action "composer install" {
  uses = "MilesChou/composer-action@master"
  args = "install -q --no-ansi --no-interaction --no-scripts --no-suggest --no-progress --prefer-dist"
}

# Run phpunit testsuite
action "phpunit" {
  needs = ["composer install"]
  uses = "./actions/run-phpunit/"
  args = "tests/"
}

# Run phpinsights
action "phpinsights" {
  needs = ["composer install"]
  uses = "stefanzweifel/laravel-phpinsights-action@v1.0.0"
  args = "-v --min-quality=80 --min-complexity=80 --min-architecture=80 --min-style=80"
}
