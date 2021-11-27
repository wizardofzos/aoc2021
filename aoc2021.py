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
        '<br />Github Repo: <a href="https://github.com/wizardofzos/aoc2021">github.com/wizardofzos/aoc2021</a>'},
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

from endpoints import REXXD01P1,PYTHOND01P1
api.add_resource(REXXD01P1, '/d01p01-rexx')
docs.register(REXXD01P1)
api.add_resource(PYTHOND01P1, '/d01p01-python')
docs.register(PYTHOND01P1)

if __name__ == '__main__':
    import os
    port = int(os.environ.get('PORT', 12345))
    app.run(debug=True, host='0.0.0.0', port=port)