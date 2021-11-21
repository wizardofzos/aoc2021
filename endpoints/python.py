from marshmallow import Schema, fields
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE

class ResponseSchema(Schema):
    '''
    All solutions should post in the field solution :)
    '''    
    solution = fields.Str(default='The answer')


#  Restful way of creating APIs through Flask Restful
class PYTHON(MethodResource, Resource):
    @doc(description='An example PYTHON-solution endpoint.', tags=['PYTHON'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    
    @marshal_with(ResponseSchema)  # marshalling
    def get(self):
        '''
        Get method represents a GET API method
        '''

        # Send our solution
        return {'solution': 9001}