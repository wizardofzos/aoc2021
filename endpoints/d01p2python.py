from marshmallow import Schema, fields
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort
from subprocess import Popen, PIPE


#  Restful way of creating APIs through Flask Restful
class PYTHOND01P2(MethodResource, Resource):
    @doc(description="See REXX :)"
    , tags=['PYTHON'],
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
        inputfile = inpath + "2021d1p1.ebcdic"
        
        with open(inputfile) as infile:
            input = infile.readlines()
        
        previous = None
        increments = 0
    
        for m in range(len(input)-2):
      
            summed = int(input[m]) + int(input[m+1]) + int(input[m+2])
            if previous:
                if  summed > previous:
                    increments += 1
            previous = summed

            

        return {'solution': increments}