# [genice2-mdanalysis](https://github.com/vitroid/genice-mdanalysis/)

A [GenIce2](https://github.com/vitroid/GenIce) format plugin to make a Universe of MDAnalysis.

version 0.6.5

## Requirements


* GenIce2>=2.1b2
* MDAnalysis

### For Apple M1

The newest MDAnalysis is required but is not available at PyPI. Follow the instructions below to install it.

```shell
% git clone https://github.com/MDAnalysis/MDAnalysis.git
% cd MDAnalysis/package; ./setup.py install
```

## Installation from PyPI

```shell
% pip install genice2-mdanalysis
```

## Manual Installation

### System-wide installation

```shell
% make install
```

### Private installation

Copy the files in genice2_mdanalysis/formats/ into your local formats/ folder.

## Usage
        
    Usage:
        % genice 1c -f mdanalysis > 1c.pickle
        % genice 1c -f mdanalysis[1c.gro]
        % genice 1c -f mdanalysis[1c.xtc]

    Options:
        filename  The file name to be written. The file type is specified by the
                  suffix. All the supported file types are listed in the
                  [MDAnalysis web page](https://docs.mdanalysis.org/stable/documentation_pages/coordinates/init.html#supported-coordinate-formats).
                  If the file name is not specified, the Universe instance of
                  MDAnalysis is written to the stdout in the python pickle
                  format.


## Test in place

```shell
% make test
```
