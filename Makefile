.DELETE_ON_ERROR:
GENICE=genice2
BASE=genice2_mdanalysis
PACKAGE=genice2-mdanalysis

all: README.md


test: ice1c.pickle
ice1c.pickle: $(BASE)/formats/mdanalysis.py Makefile
	( cd $(BASE) && $(GENICE) 1c -r 2 2 2 -f mdanalysis --debug) > $@
%.test:
	make $*
	diff $* ref/$*


%: temp_% replacer.py $(wildcard $(BASE)/lattices/*.py) $(wildcard $(BASE)/*.py)
	pip install genice2_dev
	python replacer.py < $< > $@





test-deploy: build
	twine upload -r pypitest dist/*
test-install:
	pip install pillow
	pip install --index-url https://test.pypi.org/simple/ $(PACKAGE)



install:
	python ./setup.py install
uninstall:
	-pip uninstall -y $(PACKAGE)
build: README.md $(wildcard $(BASE)/lattices/*.py) $(wildcard $(BASE)/*.py)
	python ./setup.py sdist bdist_wheel


deploy: build
	twine upload dist/*
check:
	./setup.py check
clean:
	-rm $(ALL) *~ */*~
	-rm -rf build dist *.egg-info
	-find . -name __pycache__ | xargs rm -rf
