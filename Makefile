clean:
	rm public/assets/*js -rf
	rm public/assets/*css -rf
	touch tmp/restart.txt
deploy:

	rake assets:precompile &

