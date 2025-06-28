.PHONY: clean setup build peek

#target=dist/python/lib/python3.11/site-packages
dist=./dist
target=$(dist)/python/lib/python3.11/site-packages
venv=./venv
pip=$(venv)/bin/pip
zipfile=layer-python3.11-requests.zip


# illustrate quick and dirty python aws layer build

clean:
	rm -rf $(dist) \
	&& rm -rf $(venv)  

setup:
	pyenv local 3.11 \
	&& python -m venv $(venv) \
	&& . $(venv)/bin/activate \
	&& $(venv)/bin/python --version \
	&& $(pip) --version  \
	&& $(pip) install --upgrade pip \
	&& $(pip) --version 

build: clean setup
	mkdir -p $(target) \
	&& $(pip) install -r ./requirements.txt --target $(target) \
	&& (cd $(dist) && zip -r ../$(dist)/$(zipfile) .) \
	&& echo "done"

peek:
	unzip -l $(dist)/$(zipfile)

