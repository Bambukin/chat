chmod a+x bin/render-build.sh
> render.yaml
git status 
le install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
