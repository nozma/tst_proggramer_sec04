NAME=ml-python-with-r

build:
	docker build -t $(NAME) .

restart: stop start

start:
	docker run -itd \
    -v ~/.rstudio-desktop/monitored/user-settings:/home/rstudio/.rstudio/monitored/user-settings \
    -v ~/.R/rstudio/keybindings:/home/rstudio/.R/rstudio/keybindings \
    -v $(PWD):/home/rstudio/doc \
    --name $(NAME) \
    -p 8787:8787 nozma/ml-python-with-r \

contener=`docker ps -a -q`
image=`docker images | awk '/^<none>/ { print $$3 }'`

clean:
	@if [ "$(image)" != "" ] ; then \
		docker rmi $(image); \
	fi
	@if [ "$(contener)" != "" ] ; then \
		docker rm $(contener); \
	fi

stop:
	docker rm -f $(NAME)

attach:
	docker exec -it $(NAME) /bin/bash

logs:
	docker logs $(NAME)
