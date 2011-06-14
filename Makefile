clean:
	rm public/assets/*js -rf
	rm public/assets/*css -rf
deploy:
	git checkout local
	git merge master
	rake assets:precompile
	touch tmp/restart.txt
	echo "deploying Done, open webbrowser and then:"
	echo "  git checkout master"
