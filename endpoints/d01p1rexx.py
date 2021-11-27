from marshmallow import Schema, fields
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE

#  Restful way of creating APIs through Flask Restful
class REXXD01P1(MethodResource, Resource):
    @doc(description="Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.", tags=['REXX'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    
    def get(self):
        '''
        Get method represents a GET API method
        '''

        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/2020d1p1.rex'], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        if parts[0] == "solution":
            return {'solution': int(parts[1].strip())}
        else:
            return {'solution': '*FAILED*'}