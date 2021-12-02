from marshmallow import Schema, fields
from flask_apispec.views import MethodResource
from flask_apispec import marshal_with, doc, use_kwargs
from flask_restful import Resource
from flask import abort

from subprocess import Popen, PIPE

import uuid
import os

class D1RequestSchema(Schema):
    puzzle = fields.Raw(required=True, description="Puzzle Input", type='file')


#  Restful way of creating APIs through Flask Restful
class REXXD01P1(MethodResource, Resource):
    @doc(description="As the submarine drops below the surface of the ocean, it automatically performs " +
    "a sonar sweep of the nearby sea floor. On a small screen, the sonar sweep report " +
    "(your puzzle input) appears: each line is a measurement of the sea floor depth as the sweep " +
    "looks further and further away from the submarine.The first order of business is to figure " +
    "out how quickly the depth increases, just so you know what you're dealing with - you never know" +
    "if the keys will get carried into deeper water by an ocean current or a fish or something." +
    "To do this, count the number of times a depth measurement increases from the previous measurement." +
    "(There is no measurement before the first measurement.)"
    , tags=['REXX'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    
    def get(self):
        '''
        Get method represents a GET API method
        '''

        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/2021d1p1.rex'], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        if parts[0] == "solution":
            return {'solution': int(parts[1].strip())}
        else:
            return {'solution': '*FAILED*'}
    
    @doc(description="As the submarine drops below the surface of the ocean, it automatically performs " +
    "a sonar sweep of the nearby sea floor. On a small screen, the sonar sweep report " +
    "(your puzzle input) appears: each line is a measurement of the sea floor depth as the sweep " +
    "looks further and further away from the submarine.The first order of business is to figure " +
    "out how quickly the depth increases, just so you know what you're dealing with - you never know" +
    "if the keys will get carried into deeper water by an ocean current or a fish or something." +
    "To do this, count the number of times a depth measurement increases from the previous measurement." +
    "(There is no measurement before the first measurement.)"
    , tags=['REXX'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    @use_kwargs(D1RequestSchema, location='files')
    def post(self, puzzle):
        # stick the file somewhere
        infile = f"/tmp/{uuid.uuid4()}"
        gofile = f"/tmp/{uuid.uuid4()}"
        puzzle.save(infile)  # will go be iso8859-1
        os.system(f"iconv -f iso8859-1 -t ibm-1047 {infile} > {gofile}")
        os.system(f"chtag -tc ibm-1047 {gofile}")
        print(infile)
        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/2021d1p1.rex',gofile], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        os.remove(infile)
        os.remove(gofile)

        if parts[0] == "solution":
            return {'solution': int(parts[1].strip())}
        else:
            return {'solution': '*FAILED*'}
        



class REXXD01P2(MethodResource, Resource):
    @doc(description="Your goal now is to count the number of times the sum of measurements in this sliding window increases from the previous sum"
    , tags=['REXX'],
    responses={
        '200': {'description': 'Everything is ok!'},
    }
    )
    
    def get(self):
        '''
        Get method represents a GET API method
        '''

        # Run the REXX
        process = Popen(['/prj/repos/aoc2021/rexxes/2021d1p2.rex'], stdout=PIPE, stderr=PIPE)
        stdout, stderr = process.communicate()
        parts = stdout.decode('utf-8').split('=')
        if parts[0] == "solution":
            return {'solution': int(parts[1].strip())}
        else:
            return {'solution': '*FAILED*'}