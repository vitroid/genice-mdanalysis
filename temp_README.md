# [{{package}}]({{url}})

A {{genice}} format plugin to make a Universe of MDAnalysis.

version {{version}}

## Requirements

{% for i in requires %}
* {{i}}
{%- endfor %}

### For Apple M1

The newest MDAnalysis is required but is not available at PyPI. Follow the instructions below to install it.

```shell
% git clone https://github.com/MDAnalysis/MDAnalysis.git
% cd MDAnalysis/package; ./setup.py install
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
