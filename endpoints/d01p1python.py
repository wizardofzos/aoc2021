from marshmallow import Schema, fields
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort
from subprocess import Popen, PIPE


#  Restful way of creating APIs through Flask Restful
class PYTHOND01P1(MethodResource, Resource):
    @doc(description="Before you leave, the Elves in accounting just need you to fix your expense report" +
    "(your puzzle input); apparently, something isn't quite adding up." +
    "Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers" + 
    "together. For example, suppose your expense report contained the following:" + 
    "1721,979,366,299,675,1456. In this list, the two entries that sum to 2020 are 1721 and 299." +
    "Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579."
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
        inputfile = inpath + "2020d1p1.ebcdic"
        with open(inputfile) as infile:
            input = infile.readlines()
        
        print(input)
        # find answer
        for i in range(len(input)):
            for j in range(len(input)):
                a = int(input[i].replace('\n',''))
                b = int(input[j].replace('\n',''))
                if i != j and a < 2020 and b < 2020:
                    if a+b == 2020:
                        solution = a*b
                        break
        return {'solution': solution}