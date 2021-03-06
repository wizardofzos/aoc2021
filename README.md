# AOC 2021 on z/OS


Based on  https://github.com/wizardofzos/flask-rest-zos/

## What's this?

Repo for my solutions to AOC2021. More info: https://adventofcode.com/2021
Wanted to have some extra practice on flask-rest and also do some REXX. 

So I've made this REST API that either runs python code, or REXX and shows the result...


## Requirements

- Conda installed
- Python available
- Network connectivity to the outside world    

## Preparing for first run

    conda activate <env-that-has-python3-in-it>
    git clone git@github.com:wizardofzos/flask-rest-zos.git
    cd flask-rest-zos
    python -m venv .
    . bin/activate  
    python3 -m pip install -r requirements.txt

## Running it
    conda activate <env-that-has-python3-in-it>      
    cd ../../flask-rest-zos
    . bin/activate
    # Optional if you want another port than 12345
    export PORT=<port-you-want>
    python3 aoc2021.py

Then point your browser to http://<ip_or_dns_of_your_mainframe>:12345/swagger-ui and...

![AOC2021](https://github.com/wizardofzos/aoc2021/blob/main/aoc2021-startup.png?raw=true)
       
    
## Adding endpoints to the REST-API

Every endpoint has it's own file in /endpoints. Make sure to add your new endpoints to /endpoints/__init__.py with a line like so:

    from .<name-of-your-resource-endpoint.py> import <ResourceName>

Then in test-app.py add these lines:

    from endpoints import <ResourceName>
    api.add_resource(<ResourceName>, '/<path-to-your-new-endpoint')
    docs.register(<ResourceName>)

And off you go :)

# TODO
Write how to add new solutions :)
