from flask import Flask
from flask_restful import Resource, Api
from apispec import APISpec
from marshmallow import Schema, fields
from apispec.ext.marshmallow import MarshmallowPlugin
from flask_apispec.extension import FlaskApiSpec
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs

app = Flask(__name__)  
api = Api(app)  


app.config.update({
    'APISPEC_SPEC': APISpec(
        title='Advent of Code 2021',
        version='v1',
        info={'description': 'My <a href="https://adventofcode.com">Advent of Code 2021</a> solutions.' +
        '<br />Github Repo: <a href="https://github.com/wizardofzos/aoc2021">github.com/wizardofzos/aoc2021</a>'+
        '<br /><b>Warning</b>:All REXX [POST] endpoints assume a puzzle input with "Windows Line Ends "' +
        '(meaning a single 0x0d).'},
        plugins=[MarshmallowPlugin()],
        openapi_version='2.0.0'
    ),
    'APISPEC_SWAGGER_URL': '/swagger/',       
    'APISPEC_SWAGGER_UI_URL': '/swagger-ui/'  
})
docs = FlaskApiSpec(app)

class ResponseSchema(Schema):
    '''
    All solutions should post in the field solution :)
    '''    
    solution = fields.Str(default='The answer')

from endpoints import REXX, PYTHON
api.add_resource(REXX, '/rexx')
docs.register(REXX)
api.add_resource(PYTHON, '/python')
docs.register(PYTHON)


from endpoints import *

api.add_resource(COBOL, '/cobol')
docs.register(COBOL)


api.add_resource(REXXD01P1, '/d01p01-rexx')
docs.register(REXXD01P1)
api.add_resource(REXXD01P2, '/d01p02-rexx')
docs.register(REXXD01P2)
api.add_resource(PYTHOND01P1, '/d01p01-python')
docs.register(PYTHOND01P1)
api.add_resource(PYTHOND01P2, '/d01p02-python')
docs.register(PYTHOND01P2)
api.add_resource(REXXD02P1, '/d02p01-rexx')
docs.register(REXXD02P1)
api.add_resource(REXXD02P2, '/d02p02-rexx')
docs.register(REXXD02P2)
api.add_resource(REXXD03P1, '/d03p01-rexx')
docs.register(REXXD03P1)
api.add_resource(REXXD03P2, '/d03p02-rexx')
docs.register(REXXD03P2)
api.add_resource(REXXD04P1, '/d04p01-rexx')
docs.register(REXXD04P1)
api.add_resource(REXXD04P2, '/d04p02-rexx')
docs.register(REXXD04P2)
api.add_resource(REXXD05P1, '/d05p01-rexx')
docs.register(REXXD05P1)
api.add_resource(REXXD05P2, '/d05p02-rexx')
docs.register(REXXD05P2)
api.add_resource(REXXD05P2a, '/d05p02a-rexx')
docs.register(REXXD05P2a)
api.add_resource(REXXD06P1, '/d06p01-rexx')
docs.register(REXXD06P1)
api.add_resource(REXXD06P2, '/d06p02-rexx')
docs.register(REXXD06P2)
api.add_resource(REXXD07P1, '/d07p01-rexx')
docs.register(REXXD07P1)
api.add_resource(REXXD07P2, '/d07p02-rexx')
docs.register(REXXD07P2)
api.add_resource(REXXD08P1, '/d08p01-rexx')
docs.register(REXXD08P1)
api.add_resource(REXXD08P2, '/d08p02-rexx')
docs.register(REXXD08P2)
api.add_resource(REXXD09P1, '/d09p01-rexx')
docs.register(REXXD09P1)
api.add_resource(REXXD09P2, '/d09p02-rexx')
docs.register(REXXD09P2)
api.add_resource(REXXD10P1, '/d10p01-rexx')
docs.register(REXXD10P1)
api.add_resource(REXXD10P2, '/d10p02-rexx')
docs.register(REXXD10P2)
api.add_resource(REXXD11P1, '/d11p01-rexx')
docs.register(REXXD11P1)
api.add_resource(REXXD11P2, '/d11p02-rexx')
docs.register(REXXD11P2)
api.add_resource(PYTHOND11, '/d11-python')
docs.register(PYTHOND11)
api.add_resource(REXXD12P1, '/d12p01-rexx')
docs.register(REXXD12P1)
api.add_resource(REXXD12P2, '/d12p02-rexx')
docs.register(REXXD12P2)
if __name__ == '__main__':
    import os
    port = int(os.environ.get('PORT', 12345))
    app.run(debug=True, host='0.0.0.0', port=port)