clean:
	rm public/assets/*js -rf
	rm public/assets/*css -rf
deploy:
	git checkout local
	git rebase local
	rake assets:precompile
	touch tmp/restart.txt
	echo "deploying Done"

