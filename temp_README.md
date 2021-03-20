# [{{package}}]({{url}})

A {{genice}} format plugin to make a Universe of MDAnalysis.

version {{version}}

## Requirements

{% for i in requires %}
* {{i}}
{%- endfor %}

The newest MDAnalysis is not available at PyPI. Follow the instructions below to install it.

```shell
% git clone https://github.com/MDAnalysis/MDAnalysis.git
% cd MDAnalysis/package; ./setup.py install
```

GenIce 2.1 is required. Follow the instruction below to install it.
```shell
% pip install git+https://github.com/vitroid/GenIce@universe
```


## Installation from PyPI

```shell
% pip install {{package}}
```

## Manual Installation

### System-wide installation

```shell
% make install
```

### Private installation

Copy the files in {{base}}/formats/ into your local formats/ folder.

## Usage

{%- filter indent %}
    {{usage}}
{%- endfilter %}

## Test in place

```shell
% make test
```
