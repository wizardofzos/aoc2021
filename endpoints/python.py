
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE


#  Restful way of creating APIs through Flask Restful
class PYTHON(MethodResource, Resource):
    @doc(description='An example PYTHON-solution endpoint.', tags=['PYTHON'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    
    def get(self):
        '''
        Get method represents a GET API method
        '''
        # get the input file
        me = __file__
        inpath = me.split('endpoints')[0] + "input/"
        inputfile = inpath + "example.ebcdic"
        with open(inputfile) as infile:
            input = infile.readlines()
        
        if input[0].strip() == "EXAMPLE INPUT FILE":
            solution = 9001
        else:
            solution = input[0].strip()
        # Send our solution
        return {'solution': solution}