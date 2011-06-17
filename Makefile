clean:
	rm public/assets/*js -rf
	rm public/assets/*css -rf
deploy:
	git checkout local
	git pull origin master
	bundle
	rake db:migrate RAILS_ENV=production
	rake assets:precompile
	touch tmp/restart.txt
	echo "deploying Done, open webbrowser and then:"
	echo "  git checkout master"
