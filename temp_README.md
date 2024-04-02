![Logo]({{tool.genice.urls.logo}})

# [{{project.name}}]({{project.urls.Homepage}})

A {{genice}} format plugin to make a Universe of MDAnalysis.

version {{version}}

## Requirements

{% for item in tool.poetry.dependencies %}* {{item}}{{tool.poetry.dependencies[item]}}
{% endfor %}

## Installation from PyPI

```shell
% pip install {{project.name}}
```

## Usage

{%- filter indent %}
    {{usage}}
{%- endfilter %}


## Test in place

```shell
% make test
```
