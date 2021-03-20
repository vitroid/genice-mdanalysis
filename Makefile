.DELETE_ON_ERROR:
GENICE=genice2
BASE=genice2_mdanalysis
PACKAGE=genice2-mdanalysis

all: README.md


test: ice1c.pickle CS1.pdb.test
# Make a picked universe of MDAnalysis
ice1c.pickle:   $(BASE)/formats/mdanalysis.py Makefile
	( cd $(BASE) && $(GENICE) 1c -r 2 2 2 -f mdanalysis --debug) > $@
CS1.pdb: $(BASE)/formats/mdanalysis.py Makefile
	( cd $(BASE) && $(GENICE) CS1 -g 12=ch4 -g 14=thf*0.5+H2*0.5 -r 2 2 2 -w spce -f mdanalysis[../$@] )
CS1_genice.gro: $(BASE)/formats/mdanalysis.py Makefile
	( cd $(BASE) && $(GENICE) CS1 -g 12=ch4 -g 14=thf*0.5+H2*0.5 -r 2 2 2 -w spce -f g ) > $@
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
