.DELETE_ON_ERROR:
GENICE=genice2
BASENAME=genice2_mdanalysis
PIPNAME=genice2-mdanalysis

all: README.md


test: ice1c.pickle CS1.pdb.test
# Make a picked universe of MDAnalysis
ice1c.pickle:   $(BASENAME)/formats/mdanalysis.py Makefile
	( cd $(BASENAME) && $(GENICE) ice1c -r 2 2 2 -f mdanalysis --debug) > $@
CS1.pdb: $(BASENAME)/formats/mdanalysis.py Makefile
	( cd $(BASENAME) && $(GENICE) CS1 -g 12=ch4 -g 14=thf*0.5+H2*0.5 -r 2 2 2 -w spce -f mdanalysis[../$@] --debug )
CS1_genice.gro: $(BASENAME)/formats/mdanalysis.py Makefile
	( cd $(BASENAME) && $(GENICE) CS1 -g 12=ch4 -g 14=thf*0.5+H2*0.5 -r 2 2 2 -w spce -f g ) > $@
%.test:
	make $*
	diff $* ref/$*


%: temp_% replacer.py $(wildcard $(BASENAME)/formats/*.py) $(wildcard $(BASENAME)/*.py) pyproject.toml
	python replacer.py $< > $@


test-deploy:
	poetry publish --build -r testpypi
test-install:
	pip install --index-url https://test.pypi.org/simple/ $(PIPNAME)
uninstall:
	-pip uninstall -y $(PIPNAME)
build: README.md $(wildcard genice2_mdanalysis/*.py)
	poetry build
deploy:
	poetry publish --build
check:
	poetry check


clean:
	-rm $(ALL) *~ */*~ *.pdb
	-rm -rf build dist *.egg-info
	-find . -name __pycache__ | xargs rm -rf
